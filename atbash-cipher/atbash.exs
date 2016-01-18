defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """

  @alphabet ?a..?z
  @rejected_characters ~r/[^a-z\d]/


  @spec encode(String.t) :: String.t
  def encode(plaintext) do
    plaintext
    |> sanitize
    |> to_char_list
    |> encode([])
    |> to_string
    |> format
  end

  defp encode([h | t], accum) do
    encode(t, [encode_letter(h) | accum])
  end

  defp encode([], accum) do
    Enum.reverse accum
  end

  defp format(string) do
    String.strip(Regex.replace(~r/(.....)/, string, "\\1 "))
  end

  defp encode_letter(letter) when letter in @alphabet do
    @alphabet.last - (letter - @alphabet.first)
  end

  defp encode_letter(letter), do: letter

  defp sanitize(string) do
    Regex.replace(@rejected_characters, String.downcase(string), "")
  end
end
