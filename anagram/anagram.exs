defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    checker = fn candidate -> check_candidate(base, candidate) end
    Enum.filter(candidates, checker)
  end

  defp check_candidate(base, candidate) do
    cond do
      String.length(base) != String.length(candidate) -> false
       same_codepoints?(base, candidate) && different_strings?(base, candidate) -> true
      :else -> false
    end
  end

  defp same_codepoints?(base, candidate) do
    sorted_codepoints(base) == sorted_codepoints(candidate)
  end

  defp different_strings?(base, candidate) do
    String.downcase(base) != String.downcase(candidate)
  end

  defp sorted_codepoints(str) do
    String.downcase(str) |> String.codepoints |> Enum.sort
  end

end
