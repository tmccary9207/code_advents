defmodule Mix.Tasks.Main do
  @moduledoc "Main for Day 2 of 2015."
  use Mix.Task

  def run(_) do
    {:ok, input} = File.read("../myinput.txt")
    total_surface_area = String.split(input)
    |> Enum.map(fn x -> Aoc2015day2.surface_area_with_slack(x) end)
    |> Enum.sum
    IO.puts("Total square feet of wrapping paper needed: #{total_surface_area}")
  end
end
