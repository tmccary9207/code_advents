defmodule Aoc2015day2Test do
  use ExUnit.Case
  doctest Aoc2015day2

  test "Calculates the surface area of a present." do
    assert Aoc2015day2.surface_area([6, 12, 8]) == 52
    assert Aoc2015day2.surface_area([1, 10, 10]) == 42
  end

  test "Calculates the surface area of a present with slack." do
    assert Aoc2015day2.surface_area_with_slack("2x3x4") == 58
    assert Aoc2015day2.surface_area_with_slack("1x1x10") == 43
  end
end
