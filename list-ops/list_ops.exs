defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count([_ | tail]) do
     1 + count(tail)
  end

  def count([]) do
    0
  end

  @spec reverse(list) :: list
  def reverse([]) do
    []
  end

  def reverse(l) do
    reverse(l, [])
  end

  defp reverse([h | t], acc) do
    reverse(t, [h | acc])
  end

  defp reverse([], acc) do
    acc
  end


  @spec map(list, (any -> any)) :: list
  def map([], _f) do
    []
  end

  def map(l, f) do
    reverse map(l, f, [])
  end

  defp map([h | t], f, acc) do
    map(t, f, [f.(h) | acc])
  end

  defp map([], _f, acc) do
    acc
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], _f) do
    []
  end

  def filter(l, f) do
    reverse filter(l, f, [])
  end

  defp filter([h | t], f, acc) do
    if f.(h) do
      filter(t, f, [h | acc])
    else
      filter(t, f, acc)
    end
  end

  defp filter([], _f, acc) do
    acc
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([h | t], acc, f) do
    reduce(t, f.(h, acc), f) 
  end

  def reduce([], acc, _f) do
    acc
  end

  @spec append(list, list) :: list
  def append([h | t], lb) do
    [h | append(t, lb)]
  end

  def append([], lb) do
    lb
  end

  def append(la, []) do
    la
  end

  def append([], []) do
    []
  end

  @spec concat([[any]]) :: [any]
  def concat([]) do
    []
  end

  def concat(enumerables) do
    create_list = &[&1 | &2]
    reverse reduce(enumerables, [], &reduce(&1, &2, create_list))
  end
end
