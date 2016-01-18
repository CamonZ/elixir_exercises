defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number) do
    words = factors_for(number) |> Enum.uniq |> Enum.reverse |> build_words([])
    if Enum.empty?(words) do
      Integer.to_string(number)
    else
      Enum.join(words, "")
    end
  end

  def build_words([], words) do
    words
  end

  def build_words([7 | t], words) do
    build_words(t,["Plong", words])
  end

  def build_words([5 | t], words) do
    [build_words(t, ["Plang" | words])]
  end

  def build_words([3 | t], words) do
    build_words(t, ["Pling" | words])
  end

  def build_words([h | t], words) do
    build_words(t, words)
  end

  defp factors_for(number) do
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
