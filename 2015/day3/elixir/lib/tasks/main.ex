defmodule Mix.Tasks.Main do
  @moduledoc "Main for Day 3 of 2015."
  use Mix.Task

  def run(_) do
    {:ok, input} = File.read("../myinput.txt")
    houses_visited = Aoc2015day3.take_directions(input)
    IO.puts("At least this many houses received a single present: #{houses_visited}")
  end
end

