defmodule Allergies do

  use Bitwise

  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t]

  @allergy_flags [
    {"eggs", 1},
    {"peanuts", 2},
    {"shellfish", 4},
    {"strawberries", 8},
    {"tomatoes", 16},
    {"chocolate", 32},
    {"pollen", 64},
    {"cats", 128}
  ]

  @allergies Enum.into(@allergy_flags, HashDict.new)


  def list(flags) do
    Enum.reduce @allergy_flags, [], fn
      ({allergy, flag}, allergies)
      when (flags &&& flag) != 0 -> [allergy|allergies]
      (foo, allergies) -> allergies
    end
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t) :: boolean
  def allergic_to?(flags, item) do
    (flags &&& @allergies[item]) != 0
  end
end
