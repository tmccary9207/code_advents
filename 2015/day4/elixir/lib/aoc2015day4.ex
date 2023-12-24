defmodule Aoc2015day4 do
  @moduledoc """
  Documentation for `Aoc2015day4`.
  """

  @doc """
  Checks to see if hash has five leading zeros.

  ## Examples

      iex> Aoc2015day4.does_hash_have_five_leading_zeros("0000012345")
      true

  """
  def does_hash_have_five_leading_zeros(hash) do
    String.slice(hash, 0..4)== "00000"
  end

  @doc """
  Gets the lowest possible positive integer that when hashed with the secret_key
  produces an MD5 hash that has five leading zeros.

  ## Examples
  
      iex>  Aoc2015day4.get_lowest_number("abcdef")
      609043
  """
  def get_lowest_number(secret_key) do
    get_lowest_number(secret_key, 0)
  end

  @doc """
  Loop for get_lowest_number that tests the hash and if it has five leading zeros
  then returns the lowest_number else goes to the next number.
  """
  def get_lowest_number(secret_key, lowest_number) do
    hash = :crypto.hash(:md5, "#{secret_key}#{lowest_number}")
      |> Base.encode16()
    if does_hash_have_five_leading_zeros(hash) do
      lowest_number
    else
      get_lowest_number(secret_key, lowest_number + 1)
    end
  end
end
