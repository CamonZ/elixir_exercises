defmodule DNA do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> DNA.to_rna('ACTG')
  'UGAC'
  """

  @complements %{?G => ?C, ?C => ?G, ?T => ?A, ?A => ?U}
   
  @spec to_rna([char]) :: [char]
  def to_rna(dna = [h | t]) do
    [Map.get(@complements, h, '') | to_rna(t)]
  end

  def to_rna([]) do
    ''
  end
end
