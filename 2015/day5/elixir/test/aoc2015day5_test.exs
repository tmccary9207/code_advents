defmodule Aoc2015day5Test do
  use ExUnit.Case
  doctest Aoc2015day5

  test "Checks if there are three or more vowels in a string." do
    assert Aoc2015day5.has_three_or_more_vowels("aei") == true
    assert Aoc2015day5.has_three_or_more_vowels("xazegov") == true
    assert Aoc2015day5.has_three_or_more_vowels("aeiouaeiouaeiou") == true
    assert Aoc2015day5.has_three_or_more_vowels("ugknbfddgicrmopn") == true
    assert Aoc2015day5.has_three_or_more_vowels("aaa") == true
    assert Aoc2015day5.has_three_or_more_vowels("jchzalrnumimnmhp") == true
    assert Aoc2015day5.has_three_or_more_vowels("haegwjzuvuyypxyu") == true
    assert Aoc2015day5.has_three_or_more_vowels("dvszwmarrgswjxmb") == false
  end

  test "Checks if there is a pair of letters repeated in a string." do
    assert Aoc2015day5.has_same_letter_pair("xx") == true
    assert Aoc2015day5.has_same_letter_pair("abcdde") == true
    assert Aoc2015day5.has_same_letter_pair("aabbccdd") == true
    assert Aoc2015day5.has_same_letter_pair("ugknbfddgicrmopn") == true
    assert Aoc2015day5.has_same_letter_pair("aaa") == true
    assert Aoc2015day5.has_same_letter_pair("jchzalrnumimnmhp") == false
    assert Aoc2015day5.has_same_letter_pair("haegwjzuvuyypxyu") == true
    assert Aoc2015day5.has_same_letter_pair("dvszwmarrgswjxmb") == true
  end

  test "Checks if there is any naughty strings in the string." do
    assert Aoc2015day5.has_no_naughty_strings("xx") == true
    assert Aoc2015day5.has_no_naughty_strings("abcdde") == false
    assert Aoc2015day5.has_no_naughty_strings("aabbccdd") == false
    assert Aoc2015day5.has_no_naughty_strings("ugknbfddgicrmopn") == true
    assert Aoc2015day5.has_no_naughty_strings("aaa") == true
    assert Aoc2015day5.has_no_naughty_strings("jchzalrnumimnmhp") == true
    assert Aoc2015day5.has_no_naughty_strings("haegwjzuvuyypxyu") == false
    assert Aoc2015day5.has_no_naughty_strings("dvszwmarrgswjxmb") == true
  end

  test "Checks if string is nice." do
    assert Aoc2015day5.is_string_nice("xx") == false
    assert Aoc2015day5.is_string_nice("abcdde") == false
    assert Aoc2015day5.is_string_nice("aabbccdd") == false
    assert Aoc2015day5.is_string_nice("ugknbfddgicrmopn") == true
    assert Aoc2015day5.is_string_nice("aaa") == true
    assert Aoc2015day5.is_string_nice("jchzalrnumimnmhp") == false
    assert Aoc2015day5.is_string_nice("haegwjzuvuyypxyu") == false
    assert Aoc2015day5.is_string_nice("dvszwmarrgswjxmb") == false
  end
end
