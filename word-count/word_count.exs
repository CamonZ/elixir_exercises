defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map()

  def count(sentence) do
    sentence
      |> clean_and_split
      |> Enum.reduce(%{}, &map_words/2)
  end

  defp clean_and_split(sentence) do
    String.downcase(sentence) |> String.split(~r{[^[:alnum:]-]}u, trim: true)
  end

  defp map_words(key, map) do
    Map.update(map, key, 1, &(&1 + 1))
  end
end
