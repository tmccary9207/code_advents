defmodule Aoc2015day10 do
  @moduledoc """
  Documentation for `Aoc2015day10`.
  """

  @doc """
  Runs the look and say sequence on the pairs N number of times.

  ## Examples

      iex> Aoc2015day10.look_and_say([[1, 1]], 1)
      [[2, 1]]

  """
  def look_and_say(pairs, iterations) do
    [[carry | _] | _] = pairs
    look_and_say(pairs, iterations, carry, 0, [])
  end

  def look_and_say([], 1, carry, count, output) do
    Enum.reverse([[count, carry] | output])
  end

  def look_and_say([], iterations, carry, count, output) when iterations > 1 do
    temp = Enum.reverse([[count, carry] | output])
    [[carry | _] | _] = temp
    look_and_say(temp, iterations - 1, carry, 0, [])
  end

  def look_and_say([[left, right] | rest], iterations, carry, count, output) do
    if carry == left do
      if right == left do
        look_and_say(rest, iterations, carry, count + 2, output)
      else
        look_and_say(rest, iterations, right, 1, [[count + 1, carry] | output])
      end
    else
      temp = [[count, carry] | output]
      if right == left do
        look_and_say(rest, iterations, right, 2, temp)
      else
        look_and_say(rest, iterations, right, 1, [[1, left] | temp])
      end
    end
  end
end
