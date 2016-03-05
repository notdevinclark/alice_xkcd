# AliceXkcd

A handler for [Alice Slack bot]. Retrieves latest, specific and random [XKCD] comics.

[Alice Slack bot]: https://github.com/alice-bot/alice
[XKCD]: http://xkcd.com/

![](http://i.imgur.com/og5mC1v.png)

## Installation

If [available in Hex](https://hex.pm/packages/alice_xkcd), the package can be installed as:

  1. Add `alice_xkcd` to your list of dependencies in `mix.exs`:

    ```elixir
    defp deps do
       [
         {:websocket_client, github: "jeremyong/websocket_client"},
         {:alice, "~> 0.2.0"},
         {:alice_xkcd, "~> 0.0.1"}
       ]
    end
    ```

  2. Add the handler to your list of registered handlers in `mix.exs`:

    ```elixir
    def application do
      [applications: [:alice],
        mod: {
          Alice, [Alice.Handlers.Xkcd, ...]}]
    end
    ```

## Usage

Use `@alice help` for more information
