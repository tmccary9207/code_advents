require 'test/unit'
require './logic'

class LogicTest < Test::Unit::TestCase
  def test_translate_instructions
    assert_equal(
      {
        "action" => "turn on",
        "fromPositionStart" => "0",
        "fromPositionEnd" => "0",
        "toPositionStart" => "999",
        "toPositionEnd" => "999"
      },
      translate_instructions("turn on 0,0 through 999,999")
    )
    assert_equal(
      {
        "action" => "toggle",
        "fromPositionStart" => "0",
        "fromPositionEnd" => "0",
        "toPositionStart" => "999",
        "toPositionEnd" => "0"
      },
      translate_instructions("toggle 0,0 through 999,0")
    )
    assert_equal(
      {
        "action" => "turn off",
        "fromPositionStart" => "499",
        "fromPositionEnd" => "499",
        "toPositionStart" => "500",
        "toPositionEnd" => "500"
      },
      translate_instructions("turn off 499,499 through 500,500")
    )
  end

  def test_run_instructions
    assert_equal(
      1_000_000,
      run_instructions("turn on 0,0 through 999,999\n")
    )
    assert_equal(
      1_000,
      run_instructions("toggle 0,0 through 999,0\n")
    )
    assert_equal(
      999_996,
      run_instructions("turn on 0,0 through 999,999\nturn off 499,499 through 500,500\n")
    )
  end

  def test_run_instructions2
    assert_equal(
      1_000_000,
      run_instructions2("turn on 0,0 through 999,999\n")
    )
    assert_equal(
      2_000,
      run_instructions2("toggle 0,0 through 999,0\n")
    )
    assert_equal(
      999_996,
      run_instructions2("turn on 0,0 through 999,999\nturn off 499,499 through 500,500\n")
    )
    assert_equal(
      1,
      run_instructions2("turn on 0,0 through 0,0\n")
    )
    assert_equal(
      2_000_000,
      run_instructions2("toggle 0,0 through 999,999\n")
    )
  end
end
