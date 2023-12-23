require 'test/unit'
require './logic'

class MoverTest < Test::Unit::TestCase
  def test_does_hash_start_with_five_zeros
    assert_equal(true, does_hash_start_with_five_zeros("000001"))
    assert_equal(false, does_hash_start_with_five_zeros("000011"))
  end

  def test_get_lowest_number
    assert_equal(609043, get_lowest_number("abcdef"))
    assert_equal(1048970, get_lowest_number("pqrstuv"))
  end
end
