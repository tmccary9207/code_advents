defmodule Aoc2015day6 do
  @moduledoc """
  Documentation for `Aoc2015day6`.
  """

  @doc """
  Translates the input into instructions.

  ## Examples

      iex> Aoc2015day6.translate_instructions("turn on 0,0 through 999,999")
      %{"action" => "turn on", "from_start" => "0", "from_end" => "0", "to_start" => "999", "to_end" => "999"}

  """
  def translate_instructions(input) do
    Regex.named_captures(
      ~r/(?<action>.*)\s(?<from_start>\d+)\,(?<from_end>\d+).*\s(?<to_start>\d+)\,(?<to_end>\d+)/,
      input
    )
  end

  @doc """
  Runs all instructions and returns the number of lights that are on.

  ## Examples

      iex> Aoc2015day6.run_instructions("turn on 0,0 through 999,999")
      1_000_000

  """
  def run_instructions(all_input) do
    all_instructions =
      String.split(all_input, "\n")
      |> Enum.map(fn x -> translate_instructions(x) end)

    run_instructions(all_instructions, %{}, &Aoc2015day6.run_instructions_action/4)
  end

  @doc """
  When no instructions are left this will calculate the number of lights that are on.
  The definition below runs the instructions, updates the light array and calls with the
  next set of instructions.
  """
  def run_instructions([], all_lights, _) do
    Map.keys(all_lights)
    |> Enum.reduce(
      0,
      fn x, x_acc ->
        all_lights[x]
        |> Map.keys()
        |> Enum.reduce(
          x_acc,
          fn y, y_acc -> get_in(all_lights, [x, y]) + y_acc end
        )
      end
    )
  end

  def run_instructions([instructions | tail], all_lights, action_handler) do
    case instructions do
      nil ->
        # Bad instructions, go to next line.
        run_instructions(tail, all_lights, action_handler)

      _ ->
        new_all_lights = run_instructions_update_lights(
          all_lights,
          instructions,
          action_handler
        )

        run_instructions(tail, new_all_lights, action_handler)
    end
  end

  @doc """
  This takes the instructions and produces a new light array with the updates.
  """
  def run_instructions_update_lights(lights, instructions, action_handler) do
    {from_start, _} = Integer.parse(instructions["from_start"])
    {to_start, _} = Integer.parse(instructions["to_start"])
    {from_end, _} = Integer.parse(instructions["from_end"])
    {to_end, _} = Integer.parse(instructions["to_end"])

    Range.new(from_start, to_start)
    |> Enum.reduce(
      lights,
      fn x, acc ->
        Range.new(from_end, to_end)
        |> Enum.reduce(
          acc,
          fn y, acc2 ->
            # run_instructions_action(instructions["action"], x, y, acc2)
            action_handler.(instructions["action"], x, y, acc2)
          end
        )
      end
    )
  end

  @doc """
  This handles updating the light array according to the action.
  """
  def run_instructions_action(action, x, y, acc) do
    case action do
      "turn on" ->
        put_in(acc, [Access.key(x, %{}), y], 1)

      "turn off" ->
        put_in(acc, [Access.key(x, %{}), y], 0)

      "toggle" ->
        case get_in(acc, [x, y]) do
          0 -> put_in(acc, [Access.key(x, %{}), y], 1)
          1 -> put_in(acc, [Access.key(x, %{}), y], 0)
          _ -> put_in(acc, [Access.key(x, %{}), y], 1)
        end
    end
  end

  @doc """
  Runs all instructions and returns the brightness of the array.

  ## Examples

      iex> Aoc2015day6.run_instructions2("toggle 0,0 through 999,999")
      2_000_000

  """
  def run_instructions2(all_input) do
    all_instructions =
      String.split(all_input, "\n")
      |> Enum.map(fn x -> translate_instructions(x) end)

    run_instructions(all_instructions, %{}, &Aoc2015day6.run_instructions2_action/4)
  end

  @doc """
  This handles updating the light array according to the action.
  """
  def run_instructions2_action(action, x, y, acc) do
    light_state = get_in(acc, [x, y]) || 0
    case action do
      "turn on" ->
        put_in(acc, [Access.key(x, %{}), y], light_state + 1)

      "turn off" ->
        case light_state do
          0 -> put_in(acc, [Access.key(x, %{}), y], 0)
            _ -> put_in(acc, [Access.key(x, %{}), y], light_state - 1)
        end
      "toggle" ->
        put_in(acc, [Access.key(x, %{}), y], light_state + 2)
    end
  end
end
