defmodule Aoc2015day2 do
  @moduledoc """
  Advent of Code Day2 Implementation
  """

  @doc """
  Calculates the surface area for a present.

  ## Examples

      iex> Aoc2015day2.surface_area([6, 12, 8])
      52

  """
  def surface_area(sides) do
    Enum.map(sides, fn x -> x * 2 end) |> Enum.sum
  end

  @doc """
  Calculates the surface area for a present with slack.

  ## Examples

      iex> Aoc2015day2.surface_area_with_slack("2x3x4")
      58
  """
  def surface_area_with_slack(input) do
    [length, width, height | _] = String.split(input, "x") |> Enum.map(fn x -> String.to_integer(x) end)
    sides = [(length * width), (width * height), (height * length)]
    surface_area(sides) + Enum.min(sides)
  end
end
