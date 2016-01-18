defmodule DNA do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> DNA.count('AATAA', ?A)
  4

  iex> DNA.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer

  def count(strand, nucleotide) do
    unless Enum.member?(@nucleotides, nucleotide), do: raise ArgumentError
    histogram(strand) |> Map.get(nucleotide)
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> DNA.nucleotide_counts('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: Dict.t
  def histogram(strand) do
    validate_strand(strand)
    Enum.reduce(strand, default_map, &update_nucleotides_map/2)
  end

  defp validate_strand(''), do: true

  defp validate_strand(strand = [h|t]) do
    if Enum.member?(@nucleotides, h), do: validate_strand(t), else: raise ArgumentError
  end

  defp update_nucleotides_map(nucleotide, map) do
    Map.update(map, nucleotide, 0, &(&1 + 1))
  end

  defp default_map do
    Enum.reduce(@nucleotides, %{}, &update_nucleotides_map/2)
  end
end
