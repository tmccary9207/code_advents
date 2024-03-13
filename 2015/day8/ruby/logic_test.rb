# frozen_string_literal: true

require 'test/unit'
require './logic'

# Tests the logic of day8 ruby implementation
class LogicTest < Test::Unit::TestCase
  def test_count_memory_chars # rubocop:disable Metrics/MethodLength
    assert_equal(
      2,
      count_memory_chars('\"\"')
    )
    assert_equal(
      2,
      count_memory_chars('\"abc\"')
    )
    assert_equal(
      3,
      count_memory_chars('\"aaa\\\"aaa\"')
    )
    assert_equal(
      5,
      count_memory_chars('\"\\x27\"')
    )
  end

  def test_count_reencode_string_chars # rubocop:disable Metrics/MethodLength
    assert_equal(
      6,
      count_reencode_string_chars('\"\"')
    )
    assert_equal(
      6,
      count_reencode_string_chars('\"abc\"')
    )
    assert_equal(
      8,
      count_reencode_string_chars('\"aaa\\"aaa\"')
    )
    assert_equal(
      7,
      count_reencode_string_chars('\"\\x27\"')
    )
  end
end
