defmodule Xkcd do
  def number(integer) do
    {:ok, %HTTPoison.Response{body: body}} = HTTPoison.get("http://xkcd.com/#{integer}/info.0.json")
    {:ok, %{"alt" => alt, "img" => img, "title" => title}} = Poison.Parser.parse(body)
    ["#{title}: #{alt}",img]
  end
end

defmodule XkcdTest do
  use ExUnit.Case, async: true

  test "number gets a specific comic by it's number" do
    number = 1176
    retrieved_comic = ["Those Not Present: 'Yeah, that squid's a total asshole.' [scoot scoot]", "http://imgs.xkcd.com/comics/those_not_present.png"]
    assert Xkcd.number(1176) == retrieved_comic
  end
end
