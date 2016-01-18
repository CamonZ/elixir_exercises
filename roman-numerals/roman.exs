defmodule Roman do
  @values_to_numerals %{
    1 => 'I',
    4 => 'IV',
    5 => 'V',
    9 => 'IX',
    10 => 'X',
    40 => 'XL',
    50 => 'L',
    90 => 'XC',
    100 => 'C',
    400 => 'CD',
    500 => 'D',
    900 => 'CM',
    1000 => 'M'
  }

  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t
  def numerals(number) do
    numeral_values = Enum.reverse Enum.sort Map.keys(@values_to_numerals)
    List.to_string Enum.reverse numeral_for(numeral_values, number, '')
  end

  defp numeral_for(numeral_values = [h | t], number, accum) do
    if number >= h do
      numeral_for(numeral_values, number - h, [@values_to_numerals[h] | accum])
    else
      numeral_for(t, number, accum)
    end
  end

  defp numeral_for([], 0, accumulator) do
    accumulator
  end
end
