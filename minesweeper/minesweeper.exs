defmodule Minesweeper do

  @doc """
  Annotate empty spots next to mines with the number of mines next to them.
  """
  @spec annotate([String.t]) :: [String.t]

  def annotate([]), do: []

  def annotate(board) do
    do_annotations(board, bounds(board)) |> format(board)
  end

  defp do_annotations(board, bounds={width, height}) do
    process_lines = fn {line, line_index}, accum  ->
      Enum.reduce(Stream.with_index(String.to_char_list(line)), accum, fn
          {?*, column_index}, accum -> add_adjacents(accum, {column_index, line_index}, bounds)
          _, accum -> accum
        end
      )
    end

    Enum.reduce(Stream.with_index(board), HashDict.new, process_lines)
  end

  defp format(annotations, board) do
    Enum.map(Stream.with_index(board), fn {line, row_index} ->
      Enum.map(Stream.with_index(String.to_char_list(line)), fn
        {?*, _} -> ?*
        {_, col_index} ->
          case annotations[{col_index, row_index}] do
            nil -> ?\s
            n   -> ?0 + n
          end
      end) |> List.to_string
    end)
  end


  @adjacent_vectors for x <- [-1, 0, 1], y <- [-1, 0, 1], x != 0 or y != 0, do: {x, y}

  defp add_adjacents(acc, indexes, bounds) do
    calculate = fn vector, accum ->
      new_vector = add_vectors(indexes, vector)
      if valid_vector?(new_vector, bounds) do
        Dict.update(accum, new_vector, 1, &(&1 + 1))
      else
        accum
      end
    end

    Enum.reduce(@adjacent_vectors, acc, calculate)
  end

  defp bounds(board), do: {board_width(board), board_height(board)}

  defp add_vectors({ox, oy}, {dx, dy}), do: {ox + dx, oy + dy}
  defp valid_vector?({ox, oy}, {width, height}), do: ox >= 0 and ox < width and oy >= 0 and oy < height
  defp board_height(board), do: length(board)
  defp board_width(board), do: String.length(hd(board))
end
