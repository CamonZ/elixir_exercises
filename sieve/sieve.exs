defmodule Sieve do

  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do
    list = range(limit)
    find_primes(list, [])
  end

  defp find_primes([], result), do: result

  defp find_primes(list = [h | t], result) do
    [h | find_primes(remove_multiples_of(h, t), t)]
  end

  defp remove_multiples_of(digit, range) do
   Enum.reject(range, fn x -> rem(x, digit) == 0 end) 
  end

  defp range(limit) do
    Enum.to_list(2..limit)
  end
end
