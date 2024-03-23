defmodule Aoc2015day8 do
  @moduledoc """
  Documentation for `Aoc2015day8`.
  """

  @doc """
  Counts the difference between the character count of
  the string literal and the memory character count.

  """
  def count_memory_chars(input) do
    no_quotes = String.trim(input, "\"")
    two_letter_match_count = length(Regex.scan(~r/(\\")|(\\\\)/, no_quotes))
    four_letter_match_count = length(Regex.scan(~r/(\\x[0-9|a-f|A-F]{2})/, no_quotes))

    String.length(input) -
      (String.length(no_quotes) - (two_letter_match_count + 3 * four_letter_match_count))
  end

  @doc """
  Counts the difference between the reencoded character count and
  the original string literal count.

  """
  def count_reencode_string_chars(input) do
    escaped_slash_count = length(Regex.scan(~r/(\\)/, input))
    escaped_quotes_count = length(Regex.scan(~r/(")/, input)) - 2
    escaped_slash_count + escaped_quotes_count + 4
  end
end
