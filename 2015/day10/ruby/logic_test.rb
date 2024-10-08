# frozen_string_literal: true

require 'test/unit'
require './logic'

# Tests the logic of day9 ruby implementation
class LogicTest < Test::Unit::TestCase
  def test_look_and_say
    assert_equal(
      "11",
      look_and_say("1")
    )
    assert_equal(
      "21",
      look_and_say("11")
    )
    assert_equal(
      "1211",
      look_and_say("21")
    )
    assert_equal(
      "111221",
      look_and_say("1211")
    )
    assert_equal(
      "312211",
      look_and_say("111221")
    )
  end
  def test_look_and_say_2
    assert_equal(
      [[2, 1]],
      look_and_say_2([[1, 1]])
    )
    assert_equal(
      [[1, 2], [1, 1]],
      look_and_say_2([[2, 1]])
    )
    assert_equal(
      [[1, 1], [1, 2], [2, 1]],
      look_and_say_2([[1, 2], [1, 1]])
    )
    assert_equal(
      [[3, 1], [2, 2], [1, 1]],
      look_and_say_2([[1, 1], [1, 2], [2, 1]])
    )
  end
end