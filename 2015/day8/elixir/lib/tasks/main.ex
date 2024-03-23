defmodule Mix.Tasks.Main do
  @moduledoc "Main for Day 8 of 2015."
  use Mix.Task

  def run(_) do
    {:ok, input} = File.read("../myinput.txt")
    trimmed = String.trim(input)

    [memory_chars, reencode_chars] =
      trimmed
      |> String.split("\n")
      |> Enum.reduce(
        [0, 0],
        fn x, [acc_mc, acc_rc] ->
          [
            acc_mc + Aoc2015day8.count_memory_chars(x),
            acc_rc + Aoc2015day8.count_reencode_string_chars(x)
          ]
        end
      )

    IO.puts(
      "The number of characters of code for string literals minus the number of characters in memory for the values of the strings is #{memory_chars}."
    )

    IO.puts(
      "The total number of characters to represent the newly encoded strings minus the number of characters of code in each original string literal is #{reencode_chars}."
    )
  end
end
