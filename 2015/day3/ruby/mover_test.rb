require 'test/unit'
require './mover'

class MoverTest < Test::Unit::TestCase
  def test_new_location
    assert_equal([0, 1], new_location([0,0], "^"))
    assert_equal([0, -1], new_location([0,0], "v"))
    assert_equal([1, 0], new_location([0,0], ">"))
    assert_equal([-1, 0], new_location([0,0], "<"))
  end

  def test_take_directions
    assert_equal(2, take_directions(">"))
    assert_equal(4, take_directions("^>v<"))
    assert_equal(2, take_directions("^v^v^v^v^v"))
  end
end
