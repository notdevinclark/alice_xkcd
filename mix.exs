defmodule AliceXkcd.Mixfile do
  use Mix.Project

  def project do
    [app: :alice_xkcd,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: "A handler for the Alice Slack bot. Retrieves latest, specific and random XKCD comics.",
     package: package,
     deps: deps]
  end

  def application do
    [applications: [:xkcd]]
  end

  defp deps do
    [
      {:websocket_client, github: "jeremyong/websocket_client"},
      {:alice, "~> 0.2.0"},
      {:xkcd, "~> 0.0.1"}
    ]
  end

  defp package do
    [files: ["lib", "config", "mix.exs", "README*"],
     maintainers: ["Devin Clark"],
     licenses: ["MIT"],
     links: %{"GitHub"          => "https://github.com/notdevinclark/alice_xkcd",
              "Docs"            => "https://github.com/notdevinclark/alice_xkcd",
              "Alice Slack bot" => "https://github.com/alice-bot/alice",
              "XKCD"            => "http://xkcd.com/"}]
  end
end
