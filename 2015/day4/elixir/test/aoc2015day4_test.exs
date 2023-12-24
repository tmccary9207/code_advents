defmodule Aoc2015day4Test do
  use ExUnit.Case
  doctest Aoc2015day4

  test "Hash has five leading zeros" do
    assert Aoc2015day4.does_hash_have_five_leading_zeros("0000012345") == true
    assert Aoc2015day4.does_hash_have_five_leading_zeros("0000112345") == false
  end

  test "Get lowest number" do
    assert Aoc2015day4.get_lowest_number("abcdef") == 609043
    assert Aoc2015day4.get_lowest_number("pqrstuv") == 1048970
  end
end
