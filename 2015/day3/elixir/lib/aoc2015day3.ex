defmodule Aoc2015day3 do
  @moduledoc """
  Advent of Code Day3 Implementation
  """

  @doc """
  Gets the new location of Santa after taking a direction from an elf.

  ## Examples
      iex> Aoc2015day3.new_location([0, 0], "^")
      [0, 1]

  """
  def new_location(current_location, direction) do
    [x, y] = current_location
    case direction do
      "^" -> [x, y + 1]
      "v" -> [x, y - 1]
      ">" -> [x + 1, y]
      "<" -> [x - 1, y]
      _ -> current_location
    end
  end

  @doc """
  Takes directions from an elf and returns the number of unique houses visited.

  ## Examples
      iex> Aoc2015day3.take_directions("^")
      2

  """
  def take_directions(directions) do
    [visited, _] = Enum.reduce(
      String.graphemes(directions),
      [MapSet.new(["0,0"]), [0, 0]],
      fn direction, [visited_acc, last_location] ->
        visited_location = new_location(last_location, direction)
        [new_x, new_y] = visited_location
        [MapSet.put(visited_acc, "#{new_x},#{new_y}"), visited_location]
      end
    )
    MapSet.size(visited)
  end
end
