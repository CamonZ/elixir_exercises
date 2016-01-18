defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: { :ok, kind } | { :error, String.t }
  def kind(a, b, c) when a > 0 and b > 0 and c > 0 do
    cond do
      violates_triangle_inequality?(a, b, c) -> {:error, "side lengths violate triangle inequality"}
      a == b && b == c -> {:ok, :equilateral}
      a == b || b == c || a == c -> {:ok, :isosceles}
      a != b && b != c -> {:ok, :scalene}
    end
  end

  def kind(a, b, c) when a <= 0 or b <= 0 or c <= 0 do
    {:error, "all side lengths must be positive" }
  end

  defp violates_triangle_inequality?(a, b, c) do
    if a + b <= c || a + c <= b || c + b <= a, do: true, else: false
  end
end
