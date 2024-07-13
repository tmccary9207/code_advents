defmodule Aoc2015day9Test do
  use ExUnit.Case
  doctest Aoc2015day9

  test "Split line of input into a list of origin, destination, distance list." do
    assert Aoc2015day9.line_to_parts("London to Dublin = 464") == ["London", "Dublin", 464]
  end

  test "Take list of parts and turn it into a map of routes." do
    parts =
      String.split(
        "London to Dublin = 464\nLondon to Belfast = 518\nDublin to Belfast = 141",
        "\n"
      )
      |> Enum.map(&Aoc2015day9.line_to_parts/1)

    assert Aoc2015day9.get_route_map(parts) == %{
             "Belfast" => %{"Dublin" => 141, "London" => 518},
             "Dublin" => %{"Belfast" => 141, "London" => 464},
             "London" => %{"Belfast" => 518, "Dublin" => 464}
           }
  end

  test "Get the 'short' or 'long'-est distance for the route map." do
    assert Aoc2015day9.get_xest_route(
             %{
               "Belfast" => %{"Dublin" => 141, "London" => 518},
               "Dublin" => %{"Belfast" => 141, "London" => 464},
               "London" => %{"Belfast" => 518, "Dublin" => 464}
             },
             999_999,
             &Aoc2015day9.shorter/2
           ) == 605

    assert(
      Aoc2015day9.get_xest_route(
        %{
          "Belfast" => %{"Dublin" => 141, "London" => 518},
          "Dublin" => %{"Belfast" => 141, "London" => 464},
          "London" => %{"Belfast" => 518, "Dublin" => 464}
        },
        0,
        &Aoc2015day9.longer/2
      ) == 982
    )
  end

  test "No locations left to visit returns the distance." do
    assert Aoc2015day9.calculate_distance_for_route(
      %{},
      0,
      123,
      [],
      [],
      fn _, _ -> true end
    ) == 123
  end

  test "Calculating the shortest from Belfast should be 605." do
    assert Aoc2015day9.calculate_distance_for_route(
      %{
        "Belfast" => %{"Dublin" => 141, "London" => 518},
        "Dublin" => %{"Belfast" => 141, "London" => 464},
        "London" => %{"Belfast" => 518, "Dublin" => 464}
      },
      999_999,
      0,
      ["Belfast"],
      ["Dublin", "London"],
      &Aoc2015day9.shorter/2
    ) == 605
  end
end
