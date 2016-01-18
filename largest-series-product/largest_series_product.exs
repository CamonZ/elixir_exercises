defmodule Series do

  @doc """
  Splits up the given string of numbers into an array of integers.
  """
  @spec digits(String.t) :: [non_neg_integer]
  def digits(number_string) do
    number_string |> String.codepoints |> Enum.map(&:erlang.binary_to_integer/1)
  end

  @doc """
  Generates sublists of a given size from a given string of numbers.
  """
  @spec slices(String.t, non_neg_integer) :: [list(non_neg_integer)]

  def slices(_number_string, 0), do: []
  def slices(number_string, size) do
    number_string |> digits |> Enum.chunk(size, 1)
  end

  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t, non_neg_integer) :: non_neg_integer
  def largest_product(number_string, size) do
   number_string |> slices(size) |> Enum.map(&product_of/1) |> largest_in_collection
  end

  defp product_of(slice) do
    Enum.reduce(slice, 1, &Kernel.*/2)
  end

  defp largest_in_collection([]), do: 1
  defp largest_in_collection(collection), do: Enum.max(collection)
end
