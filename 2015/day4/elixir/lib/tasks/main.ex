defmodule Mix.Tasks.Main do
  @moduledoc "Main for Day 4 of 2015."
  use Mix.Task

  def run(_) do
    lowest_number = Aoc2015day4.get_lowest_number("bgvyzdsv")
    IO.puts("The lowest number that will create an adventcoin with our key is: #{lowest_number}")
  end
end

