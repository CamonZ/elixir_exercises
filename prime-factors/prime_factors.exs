defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest. 
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    Enum.reverse decompose(number, 2, [])
  end

  defp decompose(number, divisor, factors) when number < divisor do
    factors
  end

  defp decompose(number, divisor, factors) when rem(number, divisor) == 0 do
    decompose(div(number, divisor), divisor, [divisor | factors])
  end

  defp decompose(number, divisor, factors) do
    decompose(number, divisor + 1, factors)
  end
end
