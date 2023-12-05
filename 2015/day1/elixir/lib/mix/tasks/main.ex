defmodule Mix.Tasks.Main do
  @moduledoc "Main for Day 1 of 2015."
  use Mix.Task

  def run(_) do
    {:ok, input} = File.read("../myinput.txt")
    floor = Aoc2015day1.which_floor(input)
    IO.puts("Santa ends up on floor: #{floor}")
  end
end
