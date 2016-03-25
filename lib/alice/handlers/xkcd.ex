defmodule Alice.Handlers.Xkcd do
  use Alice.Router

  route ~r/\bxkcd (\d+)\z/i, :number
  route ~r/\bxkcd( latest)?\z/i, :latest
  route ~r/\bxkcd random\z/i, :random

  @doc "`xkcd <number>` - get a specific XKCD"
  def number(conn) do
    conn
    |> Alice.Conn.last_capture(conn)
    |> Integer.parse
    |> case do
      {number, _} -> Xkcd.number(number)
      :error      -> {:error, "Please pass a valid number."}
    end
    |> comic_reply(conn)
  end

  @doc "`xkcd [latest]` - get the latest XKCD"
  def latest(conn), do: handle(conn, :latest)

  @doc "`xkcd random` - get a random XKCD"
  def random(conn), do: handle(conn, :random)

  defp handle(conn, name) do
    apply(Xkcd, name, [])
    |> comic_reply(conn)
  end

  defp comic_reply({:ok, comic=%Xkcd.Comic{}}, conn) do
    conn
    |> reply("*#{comic.num}* #{comic.title}: _#{comic.alt}_")
    |> reply(comic.img)
  end
  defp comic_reply({:error, message}, conn), do: message |> reply(conn)
end
