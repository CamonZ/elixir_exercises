defmodule Bob do
  def hey(input) do
    cond do
      is_silence?(input)  -> "Fine. Be that way!"
      is_question?(input) -> "Sure."
      is_shouting?(input) -> "Whoa, chill out!"
      :else               -> "Whatever."
    end
  end

  defp is_silence?(input) do
    String.strip(input) |> String.length == 0
  end

  defp is_shouting?(input) do
    String.upcase(input) == input && String.downcase(input) != input
  end

  defp is_question?(input) do
    String.ends_with?(input, "?")
  end
end
