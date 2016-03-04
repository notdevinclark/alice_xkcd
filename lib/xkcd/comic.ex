defmodule Xkcd.Comic do
  @derive [Poison.Encoder]
  defstruct [:alt, :img, :title, :num]
end
