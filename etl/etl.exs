defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(Dict.t) :: map()
  def transform(input) do
    map_scores(Map.keys(input), input, %{})
  end

  defp map_scores([score | scores], input, accum) do
    map_scores(scores, input, assign_score_to_word(Map.get(input, score), score, accum)) 
  end

  defp map_scores([], input, accum) do
    accum
  end

  defp assign_score_to_word([word | collection], score, accum) do
    assign_score_to_word(collection, score, Map.put(accum, String.downcase(word), score))
  end

  defp assign_score_to_word([], score, accum) do
    accum
  end
end
