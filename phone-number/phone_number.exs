defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("123-456-7890")
  "1234567890"

  iex> Phone.number("+1 (303) 555-1212")
  "3035551212"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t) :: String.t
  def number(raw) do
    if is_valid?(raw) do
      ten_digits_for(raw)
    else
      "0000000000"
    end
  end

  defp is_valid?(raw) do
    number = clean(raw)
    cond do
      String.length(number) == 10 -> true
      String.length(number) == 11 && String.at(number, 0) == "1" -> true
      :else -> false
    end
  end

  defp clean(raw) do
    String.replace(raw, ~r{[[:punct:][:blank:]]}, "")
  end

  defp ten_digits_for(raw) do
    number = clean(raw)
    if String.length(number) == 10, do: number, else: String.split_at(number, 1) |> elem(1)
  end


  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("123-456-7890")
  "123"

  iex> Phone.area_code("+1 (303) 555-1212")
  "303"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    number(raw) |> number_parts |> elem(0)
  end

  defp number_parts(number) do
    area_tuple = String.split_at(number, 3)
    central_with_extension = elem(area_tuple, 1)
    central_tuple = String.split_at(central_with_extension, 3)
    { elem(area_tuple, 0), elem(central_tuple, 0), elem(central_tuple, 1) }
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("123-456-7890")
  "(123) 456-7890"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    valid_number = number(raw)
    number_in_parts = number_parts(valid_number)
    "(#{elem(number_in_parts, 0)}) #{elem(number_in_parts, 1)}-#{elem(number_in_parts, 2)}"
  end
end
