require 'test/unit'
require './reducer'

class ReducerTests < Test::Unit::TestCase
  def test_example1
    assert_equal(0, reducer("(())"))
    assert_equal(0, reducer("()()"))
  end

  def test_example2
    assert_equal(3, reducer("((("))
    assert_equal(3, reducer("(()(()("))
    assert_equal(3, reducer("))((((("))
  end

  def test_example3
    assert_equal(-1, reducer("())"))
    assert_equal(-1, reducer("))("))
  end

  def test_example4
    assert_equal(-3, reducer(")))"))
    assert_equal(-3, reducer(")())())"))
  end
end
