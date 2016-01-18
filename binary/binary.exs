defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t) :: non_neg_integer
  def to_decimal(string) do
    digits = string |> String.codepoints |> Enum.reverse
    if Enum.all?(digits, fn x -> x == "0" || x == "1" end), do: convert(digits, 0, 0), else: 0
  end

  defp convert([], _power, accum) do
    accum
  end

  defp convert([h | t], power, accum) do
    pow = if h == "0", do: 0, else: square(power)
    convert(t, power + 1, accum + pow)
  end

  defp square(number) when number < 1  do
    1
  end

  defp square(number) do
    2 * square(number - 1)
  end

end
