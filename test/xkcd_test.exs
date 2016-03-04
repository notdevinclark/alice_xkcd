defmodule Comic do
  @derive [Poison.Encoder]
  defstruct [:alt, :img, :title, :num]
end

defmodule Xkcd do
  def number(integer) do
    "http://xkcd.com/#{integer}/info.0.json"
    |> get_comic
  end

  def latest do
    "http://xkcd.com/info.0.json"
    |> get_comic
  end

  def random do
    {:ok, %Comic{num: max_num}} = Xkcd.latest
    max_num
    |> :rand.uniform
    |> number

  end

  defp get_comic(url) do
    url
    |> HTTPoison.get
    |> get_body
    |> parse_body
  end

  defp get_body({:ok, %HTTPoison.Response{status_code: 404}}), do: {:error, "Comic Not Found"}
  defp get_body({:ok, %HTTPoison.Response{body: body}}), do: {:ok, body}

  defp parse_body({:ok, body}), do: {:ok, Poison.decode!(body, as: %Comic{})}
  defp parse_body(error), do: error
end

defmodule XkcdTest do
  use ExUnit.Case, async: true

  test "number gets a specific comic by it's number" do
    retrieved_comic = %Comic{title: "Those Not Present", alt: "'Yeah, that squid's a total asshole.' [scoot scoot]", img: "http://imgs.xkcd.com/comics/those_not_present.png", num: 1176}
    assert {:ok, ^retrieved_comic} = Xkcd.number(1176)
  end

  test "number returns an error if the comic doesn't exist" do
    assert {:error, "Comic Not Found"} = Xkcd.number(0)
  end

  test "latest returns the latest comic" do
    assert {:ok, %Comic{}} = Xkcd.latest
  end

  test "random gets a random comic" do
    {:ok, %Comic{num: max_num}} = Xkcd.latest
    {:ok, %Comic{num: num}} = Xkcd.random
    assert num in 1..max_num
  end
end
