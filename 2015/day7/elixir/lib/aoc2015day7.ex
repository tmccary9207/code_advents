import Bitwise

defmodule Aoc2015day7 do
  @moduledoc """
  Documentation for `Aoc2015day7`.
  """

  @doc """
  Parses wire instruction + label string into a label and wire instruction tuple.

  ## Examples

      iex> Aoc2015day7.line_processor("ls AND lf -> x")
      {"x", %{:action => "AND", :named_args => ["ls", "lf"], :numerical_args => []}}

  """
  def line_processor(line) do
    [unprocessed, label] = String.split(line, " -> ")
    action = List.first(Regex.run(~r/[A-Z]+/, unprocessed) || [])
    named_args = Regex.scan(~r/[a-z]+/, unprocessed) |> List.flatten()

    numerical_args =
      Regex.scan(~r/[0-9]+/, unprocessed) |> List.flatten() |> Enum.map(&String.to_integer/1)

    {label, %{:action => action, :named_args => named_args, :numerical_args => numerical_args}}
  end

  @doc """
  Parses a string containing all instructions into a label/wire tuple list.

  ## Examples

      iex> Aoc2015day7.parse_to_wire_and_label_tuples("ls AND lf -> x\\n1 OR 2 -> y")
      [
        {"x", %{:action => "AND", :named_args => ["ls", "lf"], :numerical_args => []}},
        {"y", %{:action => "OR", :named_args => [], :numerical_args => [1, 2]}}
      ]

  """
  def parse_to_wire_and_label_tuples(input) do
    input
    |> String.split("\n")
    |> Enum.map(&line_processor/1)
  end

  @doc """
  Checks if all named_args are in the calculated wire value map.

  ## Examples

      iex> Aoc2015day7.all_named_args_present?(%{"x" => 1, "y" =>2}, ["x", "y"])
      true

  """
  def all_named_args_present?(calculations, named_args) do
    named_args
    |> Enum.all?(fn arg -> Map.has_key?(calculations, arg) end)
  end

  @doc """
  Calculates the value for the wire.

  ## Examples

      iex> Aoc2015day7.calculate_value(%{:action => "AND", :named_args => [], :numerical_args => [5, 3]}, %{})
      1

  """
  def calculate_value(wire_instructions, calculations) do
    all_args =
      Enum.map(wire_instructions.named_args, fn x -> calculations[x] end) ++
        wire_instructions.numerical_args

    case wire_instructions.action do
      "AND" -> Enum.at(all_args, 0) &&& Enum.at(all_args, 1)
      "OR" -> Enum.at(all_args, 0) ||| Enum.at(all_args, 1)
      "LSHIFT" -> Enum.at(all_args, 0) <<< Enum.at(all_args, 1)
      "RSHIFT" -> Enum.at(all_args, 0) >>> Enum.at(all_args, 1)
      "NOT" -> ~~~Enum.at(all_args, 0) &&& 0xF
      _ -> Enum.at(all_args, 0)
    end
  end

  @doc """
  Inner loop for running instructions and getting the value for target wire's label.

  ## Examples

      iex> Aoc2015day7.run_instructions_inner("a", %{"a" => 1}, [{"x", %{:action => "AND", :named_args => ["ls", "lf"], :numerical_args => []}}])
      1

  """
  def run_instructions_inner(target_wire, calculations, labels_and_wires) do
    if Map.has_key?(calculations, target_wire) do
      Map.get(calculations, target_wire)
    else
      [reduced_calculations, reduced_labels_and_wires] =
        Enum.reduce(
          labels_and_wires,
          [calculations, []],
          fn x, [acc_calculations, acc_labels_and_wires] ->
            {label, wire_instructions} = x

            if all_named_args_present?(acc_calculations, wire_instructions.named_args) do
              [
                Map.put(
                  acc_calculations,
                  label,
                  calculate_value(wire_instructions, acc_calculations)
                ),
                acc_labels_and_wires
              ]
            else
              [acc_calculations, [x | acc_labels_and_wires]]
            end
          end
        )

      run_instructions_inner(target_wire, reduced_calculations, reduced_labels_and_wires)
    end
  end

  @doc """
  Main loop for running instructions and getting the value for target wire's label.

  ## Examples

      iex> Aoc2015day7.run_instructions("123 -> x\\n456 -> y\\nx AND y -> d\\nx OR y -> e\\nx LSHIFT 2 -> f\\ny RSHIFT 2 -> g\\nNOT x -> h\\nNOT y -> i", "d")
      72

  """
  def run_instructions(instructions, target_wire) do
    labels_and_wires = parse_to_wire_and_label_tuples(instructions)

    run_instructions_inner(target_wire, %{}, labels_and_wires)
  end


  @doc """
  Main loop for running instructions and getting the value for target wire's label with an overridden value.

  ## Examples

      iex> Aoc2015day7.run_instructions_override("123 -> x\\n456 -> y\\nx AND y -> d\\nx OR y -> e\\nx LSHIFT 2 -> f\\ny RSHIFT 2 -> g\\nNOT x -> h\\nNOT y -> i", "d", "x", 321)
      320

  """
  def run_instructions_override(instructions, target_wire, override_label, override_value) do
    overridden_labels_and_wires =
      Enum.map(parse_to_wire_and_label_tuples(instructions), fn x ->
        {label, _} = x

        if label == override_label do
          {label, %{:action => "", :named_args => [], :numerical_args => [override_value]}}
        else
          x
        end
      end)

    run_instructions_inner(target_wire, %{}, overridden_labels_and_wires)
  end
end
