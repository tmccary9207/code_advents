defmodule Mix.Tasks.Main do
  @moduledoc "Main for Day 10 of 2015."
  use Mix.Task

  def run(_) do
    forty_runs = Aoc2015day10.look_and_say([[1, 1], [1, 3], [2, 2], [2, 1], [1, 3]], 40)

    IO.puts(
      "After 40 applications of LookAndSay the length is: #{length(forty_runs) * 2}"
    )

    IO.puts(
      "After 50 applications of LookAndSay the length is: #{length(Aoc2015day10.look_and_say(forty_runs, 10)) * 2}"
    )
  end
end
