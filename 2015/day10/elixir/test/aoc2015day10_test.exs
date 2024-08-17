defmodule Aoc2015day10Test do
  use ExUnit.Case
  doctest Aoc2015day10

  test "Runs the look and say sequence on the pairs N number of times." do
    assert Aoc2015day10.look_and_say([[1, 1]], 1) == [[2, 1]]
    assert Aoc2015day10.look_and_say([[1, 1]], 2) == [[1, 2], [1, 1]]
    assert Aoc2015day10.look_and_say([[1, 1]], 3) == [[1, 1], [1, 2], [2, 1]]
    assert Aoc2015day10.look_and_say([[1, 1]], 4) == [[3, 1], [2, 2], [1, 1]]
  end
end
