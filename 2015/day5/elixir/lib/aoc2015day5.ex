defmodule Aoc2015day5 do
  @moduledoc """
  Documentation for `Aoc2015day5`.
  """

  @doc """
  Checks if there are three or more vowels in a string.

  ## Examples

      iex> Aoc2015day5.has_three_or_more_vowels("aei")
      true

  """
  def has_three_or_more_vowels(datum) do
    length(Regex.scan(~r/([aeiou])/, datum)) > 2
  end

  @doc """
  Checks if there is a pair of letters repeated in a string.

  ## Examples

      iex> Aoc2015day5.has_same_letter_pair("xx")
      true

  """
  def has_same_letter_pair(datum) do
    length(Regex.scan(~r/(.)\1{1,}/, datum)) > 0
  end

  @doc """
  Checks if there is any naughty strings in the string.

  ## Examples

      iex> Aoc2015day5.has_no_naughty_strings("ugknbfddgicrmopn")
      true

  """
  def has_no_naughty_strings(datum) do
    length(Regex.scan(~r/(ab)|(cd)|(pq)|(xy)/, datum)) < 1
  end

  @doc """
  Checks if string is nice.

  ## Examples

      iex> Aoc2015day5.is_string_nice("ugknbfddgicrmopn")
      true

  """
  def is_string_nice(datum) do
    has_three_or_more_vowels(datum) && has_same_letter_pair(datum) &&
      has_no_naughty_strings(datum)
  end
end
