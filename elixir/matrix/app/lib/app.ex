defmodule App do
  @moduledoc """
  Documentation for App.
  """

  def get_zeros(matrix) do
    matrix 
    |> Enum.with_index() 
    |> Enum.flat_map(
      fn({row, row_index}) -> 
        Enum.with_index(row) 
        |> Enum.map(fn({val, col_index}) -> if val == 0, do: {row_index, col_index}, else: nil 
      end)
    end) 
    |> Enum.filter(&(&1 != nil)) 
    |> Enum.reduce(%{rows: [], cols: []}, 
      fn({row, col}, acc) -> 
        acc 
        |> Map.update(:rows, [], &(Enum.uniq(&1 ++ [row]))) 
        |> Map.update(:cols, [], (&(Enum.uniq(&1 ++ [col])))) end)
  end

  def update_matrix(matrix) do
    updates = get_zeros(matrix)

    matrix 
    |> Enum.with_index() 
    |> Enum.map(fn({row, row_index}) -> 
      Enum.map(row, fn(_) -> Enum.with_index(row) end) 
    end) 
    |> Enum.flat_map(fn(row) ->
      Enum.uniq(row) 
    end) 
    |> Enum.with_index() 
    |> Enum.map(fn({row, row_index}) -> 
      Enum.map(row, fn({val, col_index}) -> \
        if val == 0 || Enum.member?(updates.cols, col_index) || Enum.member?(updates.rows, row_index), do: 0, else: 1 
      end) 
    end)    
  end
end
