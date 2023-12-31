defmodule Aoc2015day6Test do
  use ExUnit.Case
  doctest Aoc2015day6

  test "translate_instructions" do
    assert Aoc2015day6.translate_instructions("turn on 0,0 through 999,999") == %{"action" => "turn on", "from_start" => "0", "from_end" => "0", "to_start" => "999", "to_end" => "999"}
    assert Aoc2015day6.translate_instructions("toggle 0,0 through 999,0") == %{"action" => "toggle", "from_start" => "0", "from_end" => "0", "to_start" => "999", "to_end" => "0"}
    assert Aoc2015day6.translate_instructions("turn off 499,499 through 500,500") == %{"action" => "turn off", "from_start" => "499", "from_end" => "499", "to_start" => "500", "to_end" => "500"}
  end

  test "run_instructions" do
    assert Aoc2015day6.run_instructions("turn on 0,0 through 999,999\n") == 1000000
    assert Aoc2015day6.run_instructions("toggle 0,0 through 999,0\n") == 1000
    assert Aoc2015day6.run_instructions("turn on 0,0 through 999,999\nturn off 499,499 through 500,500\n") == 999996
  end

  test "run_instructions2" do
    assert Aoc2015day6.run_instructions2("turn on 0,0 through 999,999\n") == 1000000
    assert Aoc2015day6.run_instructions2("toggle 0,0 through 999,0\n") == 2000
    assert Aoc2015day6.run_instructions2("turn on 0,0 through 999,999\nturn off 499,499 through 500,500\n") == 999996
    assert Aoc2015day6.run_instructions2("turn on 0,0 through 0,0\n") == 1
    assert Aoc2015day6.run_instructions2("toggle 0,0 through 999,999\n") == 2000000
  end
end
