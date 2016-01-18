defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(Dict.t, String.t, pos_integer) :: Dict.t
  def add(db, name, grade) do
    Map.put(db, grade, [ name |grade(db, grade) ])
  end

  @doc """
  Return the names of the students in a particular grade.
  """
  @spec grade(Dict.t, pos_integer) :: [String]
  def grade(db, grade) do
    if (Map.has_key?(db, grade)), do: Map.get(db, grade), else: []
  end

  @doc """
  Sorts the school by grade and name.
  """
  @spec sort(Dict) :: Dict.t
  def sort(db) do
    sort(db, Map.keys(db))
  end

  defp sort(db, keys = [h | t]) do
    Map.put(db, h, Enum.sort(Map.get(db, h))) |> sort(t)
  end

  defp sort(db, []) do
    db
  end
end
