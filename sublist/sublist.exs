defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      a === b         -> :equal
      contains?(a, b) -> :sublist
      contains?(b, a) -> :superlist
      :else           -> :unequal
    end
  end

  defp contains?(sublist, superlist) do
    sublist_size = Enum.count(sublist)

    cond do
      sublist_size > Enum.count(superlist) -> false
      Enum.take(superlist, sublist_size) === sublist -> true
      :else -> contains?(sublist, tl(superlist))
    end
  end
end
