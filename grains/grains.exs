defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """

  def square(number) when number <= 1  do
    1
  end

  @spec square(pos_integer) :: pos_integer
  def square(number) do
    2 * square(number - 1)
  end

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total do
    Enum.reduce(total(64, []), fn (x, acc) -> x + acc end)
  end

  defp total(number, accum) when number >= 2 do
    total(number - 1, [square(number) | accum])
  end

  defp total(number, accum) when number <= 1 do
    [1 | accum]
  end
end
