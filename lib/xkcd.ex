defmodule Xkcd do
  alias Xkcd.Comic

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
