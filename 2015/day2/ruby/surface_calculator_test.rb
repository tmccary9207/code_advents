require 'test/unit'
require './surface_calculator'

class SurfaceCalculatorTest < Test::Unit::TestCase
  def test_surface_area_1
    assert_equal(52, surface_area([6, 12, 8]))
  end

  def test_surface_area_2
    assert_equal(42, surface_area([1, 10, 10]))
  end

  def test_surface_area_with_slack_1
    assert_equal(58, surface_area_with_slack("2x3x4"))
  end

  def test_surface_area_with_slack_2
    assert_equal(43, surface_area_with_slack("1x1x10"))
  end
end
