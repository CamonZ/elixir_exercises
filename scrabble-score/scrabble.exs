defmodule Scrabble do

  @letter_scores %{
    ?a=> 1, ?e=> 1, ?i=> 1, ?o=> 1, ?u=> 1, ?l=> 1, ?n=> 1, ?r=> 1, ?s=> 1, ?t=> 1,
    ?d=> 2, ?g=> 2,
    ?b=> 3, ?c=> 3, ?m=> 3, ?p=> 3,
    ?f=> 4, ?h=> 4, ?v=> 4, ?w=> 4, ?y=> 4,
    ?k=> 5,
    ?j=> 8, ?x=> 8,
    ?q=> 10, ?z=> 10
  }

  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t) :: non_neg_integer
  def score(word) do
    word |> String.downcase |> String.to_char_list |> score(0)
  end

  defp score(word = [h | t], accum) do
    score(t, accum + score_for_letter(h))
  end

  defp score([], accum) do
    accum
  end

  defp score_for_letter(letter) do
    Map.get(@letter_scores, letter, 0)
  end
end
