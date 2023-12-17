defmodule Aoc2015day3Test do
  use ExUnit.Case
  doctest Aoc2015day3

  test "Gets the new location of Santa after a direction." do
    assert Aoc2015day3.new_location([0, 0], "^") == [0, 1]
    assert Aoc2015day3.new_location([0, 0], "v") == [0, -1]
    assert Aoc2015day3.new_location([0, 0], ">") == [1, 0]
    assert Aoc2015day3.new_location([0, 0], "<") == [-1, 0]
  end

  test "Takes directions from an elf and returns the unique number of houses visited." do
    assert Aoc2015day3.take_directions(">") == 2
    assert Aoc2015day3.take_directions("^>v<") == 4
    assert Aoc2015day3.take_directions("^v^v^v^v^v") == 2
  end
end
