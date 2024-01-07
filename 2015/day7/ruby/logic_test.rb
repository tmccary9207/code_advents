# frozen_string_literal: true

require 'test/unit'
require './logic'

# Tests the logic of day7 ruby implementation
# rubocop:disable Metrics/ClassLength
class LogicTest < Test::Unit::TestCase
  def test_translate_instructions # rubocop:disable Metrics/MethodLength
    assert_equal(
      ['x', { 'wire_value' => 123 }],
      translate_instructions('123 -> x')
    )
    assert_equal(
      ['x', { 'source' => 'a' }],
      translate_instructions('a -> x')
    )
    assert_equal(
      ['z', { 'logic_left' => 'x', 'logic_right' => 'y', 'logic_operator' => 'AND' }],
      translate_instructions('x AND y -> z')
    )
    assert_equal(
      ['q', { 'logic_left' => 'p', 'logic_right' => 2, 'logic_operator' => 'LSHIFT' }],
      translate_instructions('p LSHIFT 2 -> q')
    )
    assert_equal(
      ['f', { 'logic_right' => 'e', 'logic_operator' => 'NOT' }],
      translate_instructions('NOT e -> f')
    )
  end

  def test_instructions_to_wire_hash # rubocop:disable Metrics/MethodLength
    assert_equal(
      {
        'x' => 123,
        'y' => 456,
        'd' => { 'logic_left' => 'x', 'logic_right' => 'y', 'logic_operator' => 'AND' },
        'e' => { 'logic_left' => 'x', 'logic_right' => 'y', 'logic_operator' => 'OR' },
        'f' => { 'logic_left' => 'x', 'logic_right' => 2, 'logic_operator' => 'LSHIFT' },
        'g' => { 'logic_left' => 'y', 'logic_right' => 2, 'logic_operator' => 'RSHIFT' },
        'h' => { 'logic_right' => 'x', 'logic_operator' => 'NOT' },
        'i' => { 'logic_right' => 'y', 'logic_operator' => 'NOT' }
      },
      instructions_to_wire_hash(
        "123 -> x\n456 -> y\nx AND y -> d\nx OR y -> e\nx LSHIFT 2 -> f\ny RSHIFT 2 -> g\nNOT x -> h\nNOT y -> i"
      )
    )
  end

  def test_can_instruction_be_performed? # rubocop:disable Metrics/MethodLength
    assert_equal(
      true,
      can_instruction_be_performed?(
        { 'logic_right' => 123, 'logic_operator' => 'NOT' },
        {}
      )
    )
    assert_equal(
      false,
      can_instruction_be_performed?(
        { 'logic_right' => 'q', 'logic_operator' => 'NOT' },
        {}
      )
    )
    assert_equal(
      true,
      can_instruction_be_performed?(
        { 'logic_right' => 'q', 'logic_operator' => 'NOT' },
        { 'q' => 1 }
      )
    )
    assert_equal(
      true,
      can_instruction_be_performed?(
        { 'logic_right' => 2, 'logic_left' => 2, 'logic_operator' => 'LSHIFT' },
        {}
      )
    )
    assert_equal(
      false,
      can_instruction_be_performed?(
        { 'logic_right' => 2, 'logic_left' => 'x', 'logic_operator' => 'RSHIFT' },
        {}
      )
    )
    assert_equal(
      true,
      can_instruction_be_performed?(
        { 'logic_right' => 2, 'logic_left' => 'x', 'logic_operator' => 'RSHIFT' },
        { 'x' => 2 }
      )
    )
    assert_equal(
      true,
      can_instruction_be_performed?(
        { 'logic_right' => 'y', 'logic_left' => 'x', 'logic_operator' => 'RSHIFT' },
        { 'x' => 2, 'y' => 1 }
      )
    )
  end

  def test_perform_instruction # rubocop:disable Metrics/MethodLength
    assert_equal(
      72,
      perform_instruction({ 'logic_left' => 'x', 'logic_right' => 'y', 'logic_operator' => 'AND' },
                          { 'x' => 123, 'y' => 456 })
    )
    assert_equal(
      507,
      perform_instruction({ 'logic_left' => 'x', 'logic_right' => 'y', 'logic_operator' => 'OR' },
                          { 'x' => 123, 'y' => 456 })
    )
    assert_equal(
      492,
      perform_instruction({ 'logic_left' => 'x', 'logic_right' => 2, 'logic_operator' => 'LSHIFT' },
                          { 'x' => 123, 'y' => 456 })
    )
    assert_equal(
      114,
      perform_instruction({ 'logic_left' => 'y', 'logic_right' => 2, 'logic_operator' => 'RSHIFT' },
                          { 'x' => 123, 'y' => 456 })
    )
    assert_equal(
      65_412,
      perform_instruction({ 'logic_right' => 'x', 'logic_operator' => 'NOT' },
                          { 'x' => 123, 'y' => 456 })
    )
    assert_equal(
      65_079,
      perform_instruction({ 'logic_right' => 'y', 'logic_operator' => 'NOT' },
                          { 'x' => 123, 'y' => 456 })
    )
  end

  def test_run_instructions
    text = "123 -> x\n456 -> y\nx AND y -> d\nx OR y -> e\nx LSHIFT 2 -> f\ny RSHIFT 2 -> g\nNOT x -> h\nNOT y -> i"
    assert_equal(72, run_instructions(text, 'd'))
    assert_equal(507, run_instructions(text, 'e'))
    assert_equal(492, run_instructions(text, 'f'))
    assert_equal(114, run_instructions(text, 'g'))
    assert_equal(65_412, run_instructions(text, 'h'))
    assert_equal(65_079, run_instructions(text, 'i'))
    assert_equal(123, run_instructions(text, 'x'))
    assert_equal(456, run_instructions(text, 'y'))
  end
end
# rubocop:enable Metrics/ClassLength
