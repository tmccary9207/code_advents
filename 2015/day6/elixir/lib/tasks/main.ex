defmodule Mix.Tasks.Main do
  @moduledoc "Main for Day 6 of 2015."
  use Mix.Task

  def run(_) do
    {:ok, input} = File.read("../myinput.txt")

    number_of_lights = Aoc2015day6.run_instructions(input)

    IO.puts("#{number_of_lights} lights are on.")

    total_brightness = Aoc2015day6.run_instructions2(input)

    IO.puts("#{total_brightness} is the total brightness.")
  end
end
