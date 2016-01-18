defmodule DNA do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> DNA.hamming_distance('AAGTCATA', 'TAGCGATC')
  4
  """

  def hamming_distance('', '') do
    0
  end

  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(strand1, strand2) do
    if Enum.count(strand1) != Enum.count(strand2), do: nil, else: calculate_distance(strand1, strand2, 0)
 end

  defp calculate_distance(strand1 = [h1|t1], strand2 = [h2|t2], acc) do
    calculate_distance(t1, t2, accumulator(h1, h2, acc)) 
  end

  defp calculate_distance([], [], acc) do
    acc
  end

  defp accumulator(h1, h2, acc) do
    if h1 != h2, do: acc + 1, else: acc
  end
end
