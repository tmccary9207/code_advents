defmodule Aoc2015day1 do
  @moduledoc """
  Advent of Code Day1 Implementation
  """

  @doc """
  Determines which floor Santa is on.

  ## Examples

      iex> Aoc2015day1.which_floor("((")
      2

  """
  def which_floor(input) do
    String.graphemes(input)
    |> Enum.reduce(0, fn
      "(", acc -> acc + 1
      ")", acc -> acc - 1
      _, acc -> acc
    end)
  end
end
