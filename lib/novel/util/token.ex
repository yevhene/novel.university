defmodule Novel.Util.Token do
  def generate(length \\ 8) do
    length
    |> :crypto.strong_rand_bytes
    |> Base.encode32
    |> binary_part(0, length)
  end
end
