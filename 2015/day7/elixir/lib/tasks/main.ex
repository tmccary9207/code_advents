defmodule Mix.Tasks.Main do
  @moduledoc "Main for Day 7 of 2015."
  use Mix.Task

  def run(_) do
    {:ok, input} = File.read("../myinput.txt")
    trimmed = String.trim(input)

    wire_a_value = Aoc2015day7.run_instructions(trimmed, "a")

    IO.puts("Wire A's value is #{wire_a_value}.")

    new_wire_a_value = Aoc2015day7.run_instructions_override(trimmed, "a", "b", wire_a_value)

    IO.puts("Wire A's value when B is overridden with #{wire_a_value} is #{new_wire_a_value}.")
  end
end
