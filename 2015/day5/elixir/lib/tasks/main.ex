defmodule Mix.Tasks.Main do
  @moduledoc "Main for Day 5 of 2015."
  use Mix.Task

  def run(_) do
    {:ok, input} = File.read("../myinput.txt")

    nice_string_count =
      String.split(input, "\n")
      |> Enum.filter(fn x -> Aoc2015day5.is_string_nice(x) end)
      |> Enum.count()

    IO.puts("#{nice_string_count} nice strings.")
  end
end
