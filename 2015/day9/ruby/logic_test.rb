# frozen_string_literal: true

require 'test/unit'
require './logic'

# Tests the logic of day9 ruby implementation
class LogicTest < Test::Unit::TestCase
  def test_line_to_parts
    assert_equal(
      ["London", "Dublin", 464],
      line_to_parts("London to Dublin = 464")
    )
  end

  def test_get_route_map
    assert_equal(
      {
        'London' => {'Dublin' => 464, 'Belfast' => 518},
        'Dublin' => {'London' => 464, 'Belfast' => 141},
        'Belfast' => {'London' => 518, 'Dublin' => 141}
      },
      get_route_map([['London', 'Dublin', 464], ['London', 'Belfast', 518], ['Dublin', 'Belfast', 141]])
    )
  end

  def test_get_shortest_route
    assert_equal(
      605,
      get_shortest_route({
        'London' => {'Dublin' => 464, 'Belfast' => 518},
        'Dublin' => {'London' => 464, 'Belfast' => 141},
        'Belfast' => {'London' => 518, 'Dublin' => 141}
      })
    )
    assert_equal(
      33,
      get_shortest_route({
        "1" => { "2" => 7, "3" => 9, "6" => 14 },
        "2" => { "1" => 7, "3" => 10, "4" => 15 },
        "3" => { "2" => 10, "4" => 11, "1" => 9, "6" => 2 },
        "4" => { "2" => 15, "3" => 11, "5" => 6 },
        "5" => { "4" => 6, "6" => 9 },
        "6" => { "5" => 9, "3" => 2, "1" => 14 }
      })
    )
  end

  def test_get_longest_route
    assert_equal(
      982,
      get_longest_route({
        'London' => {'Dublin' => 464, 'Belfast' => 518},
        'Dublin' => {'London' => 464, 'Belfast' => 141},
        'Belfast' => {'London' => 518, 'Dublin' => 141}
      })
    )
    assert_equal(
      58,
      get_longest_route({
        "1" => { "2" => 7, "3" => 9, "6" => 14 },
        "2" => { "1" => 7, "3" => 10, "4" => 15 },
        "3" => { "2" => 10, "4" => 11, "1" => 9, "6" => 2 },
        "4" => { "2" => 15, "3" => 11, "5" => 6 },
        "5" => { "4" => 6, "6" => 9 },
        "6" => { "5" => 9, "3" => 2, "1" => 14 }
      })
    )
  end
end
