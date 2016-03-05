defmodule Alice.Handlers.Xkcd do
  use Alice.Router

  route ~r/\bxkcd (\d+)\b/, :number
  route ~r/\bxkcd( latest)?\z/, :latest
  route ~r/\bxkcd random\b/, :random

  @doc "`xkcd <number>` - get a specific XKCD"
  def number(conn) do
    conn.message.captures
    |> Enum.reverse
    |> hd
    |> Integer.parse
    |> case do
      {number, _} -> Xkcd.number(number)
      :error      -> "Not A Number"
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
    conn = reply("*#{comic.num}* #{comic.title}: _#{comic.alt}_", conn)
    reply(comic.img, conn)
  end
end
