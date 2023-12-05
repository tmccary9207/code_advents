defmodule Aoc2015day1Test do
  use ExUnit.Case
  doctest Aoc2015day1

  test "calculates what floor Santa is on" do
    assert Aoc2015day1.which_floor("(())") == 0
    assert Aoc2015day1.which_floor("()()") == 0
    assert Aoc2015day1.which_floor("(((") == 3
    assert Aoc2015day1.which_floor("(()(()(") == 3
    assert Aoc2015day1.which_floor("))(((((") == 3
    assert Aoc2015day1.which_floor("())") == -1
    assert Aoc2015day1.which_floor("))(") == -1
    assert Aoc2015day1.which_floor(")))") == -3
    assert Aoc2015day1.which_floor(")())())") == -3
  end
end
