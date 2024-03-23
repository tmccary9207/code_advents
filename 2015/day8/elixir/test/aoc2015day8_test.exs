defmodule Aoc2015day8Test do
  use ExUnit.Case
  doctest Aoc2015day8

  test "count memory chars" do
    assert Aoc2015day8.count_memory_chars("\"\"") == 2
    assert Aoc2015day8.count_memory_chars("\"abc\"") == 2
    assert Aoc2015day8.count_memory_chars("\"aaa\\\"aaa\"") == 3
    assert Aoc2015day8.count_memory_chars("\"\\x27\"") == 5
    assert Aoc2015day8.count_memory_chars("\"xrgcripdu\\x4c\\xc4gszjhrvumvz\\\"mngbirb\"") == 9
    assert Aoc2015day8.count_memory_chars("\"\\\\\\\\zkisyjpbzandqikqjqvee\"") == 4
  end

  test "count reencode string chars" do
    assert Aoc2015day8.count_reencode_string_chars("\"\"") == 4
    assert Aoc2015day8.count_reencode_string_chars("\"abc\"") == 4
    assert Aoc2015day8.count_reencode_string_chars("\"aaa\\\"aaa\"") == 6
    assert Aoc2015day8.count_reencode_string_chars("\"\\x27\"") == 5
  end
end
