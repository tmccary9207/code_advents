require 'test/unit'
require './logic'

class LogicTest < Test::Unit::TestCase
  def test_has_three_or_more_vowels
    assert_equal(true, has_three_or_more_vowels("aei"))
    assert_equal(true, has_three_or_more_vowels("xazegov"))
    assert_equal(true, has_three_or_more_vowels("aeiouaeiouaeiou"))
    assert_equal(true, has_three_or_more_vowels("ugknbfddgicrmopn"))
    assert_equal(true, has_three_or_more_vowels("aaa"))
    assert_equal(true, has_three_or_more_vowels("jchzalrnumimnmhp"))
    assert_equal(true, has_three_or_more_vowels("haegwjzuvuyypxyu"))
    assert_equal(false, has_three_or_more_vowels("dvszwmarrgswjxmb"))
  end

  def test_has_letter_pair
    assert_equal(true, has_same_letter_pair("xx"))
    assert_equal(true, has_same_letter_pair("abcdde"))
    assert_equal(true, has_same_letter_pair("aabbccdd"))
    assert_equal(true, has_same_letter_pair("ugknbfddgicrmopn"))
    assert_equal(true, has_same_letter_pair("aaa"))
    assert_equal(false, has_same_letter_pair("jchzalrnumimnmhp"))
    assert_equal(true, has_same_letter_pair("haegwjzuvuyypxyu"))
    assert_equal(true, has_same_letter_pair("dvszwmarrgswjxmb"))
  end

  def test_has_no_naughty_strings
    assert_equal(true, has_no_naughty_strings("xx"))
    assert_equal(false, has_no_naughty_strings("abcdde"))
    assert_equal(false, has_no_naughty_strings("aabbccdd"))
    assert_equal(true, has_no_naughty_strings("ugknbfddgicrmopn"))
    assert_equal(true, has_no_naughty_strings("aaa"))
    assert_equal(true, has_no_naughty_strings("jchzalrnumimnmhp"))
    assert_equal(false, has_no_naughty_strings("haegwjzuvuyypxyu"))
    assert_equal(true, has_no_naughty_strings("dvszwmarrgswjxmb"))
  end

  def test_is_string_nice
    assert_equal(false, is_string_nice("xx"))
    assert_equal(false, is_string_nice("abcdde"))
    assert_equal(false, is_string_nice("aabbccdd"))
    assert_equal(true, is_string_nice("ugknbfddgicrmopn"))
    assert_equal(true, is_string_nice("aaa"))
    assert_equal(false, is_string_nice("jchzalrnumimnmhp"))
    assert_equal(false, is_string_nice("haegwjzuvuyypxyu"))
    assert_equal(false, is_string_nice("dvszwmarrgswjxmb"))
  end
end
