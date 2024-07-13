defmodule Mix.Tasks.Main do
  @moduledoc "Main for Day 9 of 2015."
  use Mix.Task

  def run(_) do
    {:ok, input} = File.read("../myinput.txt")
    trimmed = String.trim(input)

    parts =
      trimmed
      |> String.split("\n")
      |> Enum.map(&Aoc2015day9.line_to_parts/1)
    routes = Aoc2015day9.get_route_map(parts)

    shortest = Aoc2015day9.get_xest_route(routes, 999_999, &Aoc2015day9.shorter/2)
    longest = Aoc2015day9.get_xest_route(routes, 0, &Aoc2015day9.longer/2)

    IO.puts(
      "Shortest possible distance is: #{shortest}"
    )

    IO.puts(
      "Longest possible distance is: #{longest}"
    )
  end
end
