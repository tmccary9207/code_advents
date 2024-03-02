defmodule Aoc2015day7Test do
  use ExUnit.Case
  doctest Aoc2015day7

  test "Parses wire instruction + label to a label and wire instruction tuple." do
    assert Aoc2015day7.line_processor("ls AND lf -> x") ==
             {"x", %{:action => "AND", :named_args => ["ls", "lf"], :numerical_args => []}}

    assert Aoc2015day7.line_processor("1 OR 2 -> y") ==
             {"y", %{:action => "OR", :named_args => [], :numerical_args => [1, 2]}}

    assert Aoc2015day7.line_processor("2 -> z") ==
             {"z", %{:action => nil, :named_args => [], :numerical_args => [2]}}

    assert Aoc2015day7.line_processor("x -> a") ==
             {"a", %{:action => nil, :named_args => ["x"], :numerical_args => []}}
  end

  test "Calculates AND instruction" do
    assert Aoc2015day7.calculate_value(
             %{:action => "AND", :named_args => [], :numerical_args => [5, 3]},
             %{}
           ) == 1

    assert Aoc2015day7.calculate_value(
             %{:action => "AND", :named_args => ["x", "y"], :numerical_args => []},
             %{"x" => 5, "y" => 3}
           ) == 1
  end

  test "Calculates OR instruction" do
    assert Aoc2015day7.calculate_value(
             %{:action => "OR", :named_args => [], :numerical_args => [5, 3]},
             %{}
           ) == 7

    assert Aoc2015day7.calculate_value(
             %{:action => "OR", :named_args => ["x", "y"], :numerical_args => []},
             %{"x" => 5, "y" => 3}
           ) == 7
  end

  test "Calculates NOT instruction" do
    assert Aoc2015day7.calculate_value(
             %{:action => "NOT", :named_args => [], :numerical_args => [7]},
             %{}
           ) == 8

    assert Aoc2015day7.calculate_value(
             %{:action => "NOT", :named_args => ["x"], :numerical_args => []},
             %{"x" => 7}
           ) == 8
  end

  test "Calculates LSHIFT instruction" do
    assert Aoc2015day7.calculate_value(
             %{:action => "LSHIFT", :named_args => [], :numerical_args => [23, 1]},
             %{}
           ) == 46

    assert Aoc2015day7.calculate_value(
             %{:action => "LSHIFT", :named_args => ["x", "y"], :numerical_args => []},
             %{"x" => 23, "y" => 1}
           ) == 46
  end

  test "Calculates RSHIFT instruction" do
    assert Aoc2015day7.calculate_value(
             %{:action => "RSHIFT", :named_args => [], :numerical_args => [23, 1]},
             %{}
           ) == 11

    assert Aoc2015day7.calculate_value(
             %{:action => "RSHIFT", :named_args => ["x", "y"], :numerical_args => []},
             %{"x" => 23, "y" => 1}
           ) == 11
  end

  test "Calculates assign instruction" do
    assert Aoc2015day7.calculate_value(
             %{:action => "", :named_args => [], :numerical_args => [23]},
             %{}
           ) == 23

    assert Aoc2015day7.calculate_value(
             %{:action => "", :named_args => ["x"], :numerical_args => []},
             %{"x" => 23}
           ) == 23
  end
end
