defmodule Comic do
  @derive [Poison.Encoder]
  defstruct [:alt, :img, :title, :num]
end
