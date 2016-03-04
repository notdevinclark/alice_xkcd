defmodule Alice.Handlers.Xkcd do
  use Alice.Router

  route ~r/\bxkcd (\d+)\b/, :number
  route ~r/\bxkcd( latest)?\z/, :latest
  route ~r/\bxkcd random\b/, :random

  def handle(conn, :number) do
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
  def handle(conn, name) when name in [:latest, :random] do
    apply(Xkcd, name, [])
    |> comic_reply(conn)
  end

  defp comic_reply({:ok, comic=%Xkcd.Comic{}}, conn) do
    conn = reply("*#{comic.num}* #{comic.title}: _#{comic.alt}_", conn)
    reply(comic.img, conn)
  end
end
