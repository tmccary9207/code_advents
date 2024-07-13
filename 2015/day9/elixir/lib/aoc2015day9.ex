defmodule Aoc2015day9 do
  @moduledoc """
  Documentation for `Aoc2015day9`.
  """

  @doc """
  Takes a line of input and splits it into origin, destination, distance list.

  ## Examples

      iex> Aoc2015day9.line_to_parts("x to y = 1")
      ["x", "y", 1]

  """
  @spec line_to_parts(bitstring()) :: list()
  def line_to_parts(input) do
    [origin, _, destination, _, distance] = String.split(input)
    [origin, destination, String.to_integer(distance)]
  end

  @doc """
  Takes a list of part lists and turns them into a route map.

  ## Examples

      iex> Aoc2015day9.get_route_map([["x", "y", 1], ["y", "z", 2]])
      %{"x" => %{"y" => 1}, "y" => %{"x" => 1, "z" => 2}, "z" => %{"y" => 2}}
  """
  @spec get_route_map(nonempty_maybe_improper_list()) :: map()
  def get_route_map(part_lists) do
    routes = %{}
    get_route_map(part_lists, routes)
  end

  @spec get_route_map([...], map()) :: map()
  def get_route_map([head | tail], routes) do
    [origin, destination, distance] = head

    updated_origin_routes =
      Map.get(routes, origin, Map.new())
      |> Map.put(destination, distance)

    updated_destination_routes =
      Map.get(routes, destination, Map.new())
      |> Map.put(origin, distance)

    updated_routes =
      Map.merge(routes, %{
        origin => updated_origin_routes,
        destination => updated_destination_routes
      })

    if length(tail) > 0 do
      get_route_map(tail, updated_routes)
    else
      updated_routes
    end
  end

  @doc """
  Checks if a is shorter than b.

  ## Examples

      iex> Aoc2015day9.shorter(1, 2)
      true
  """
  @spec shorter(integer(), integer()) :: boolean()
  def shorter(a, b) do
    a < b
  end

  @doc """
  Checks if a is longer than b.

  ## Examples

      iex> Aoc2015day9.longer(1, 2)
      false
  """
  @spec longer(integer(), integer()) :: boolean()
  def longer(a, b) do
    a > b
  end

  @doc """
  Calculates the shortest or longest route from the route map using a comparator.
  """
  def get_xest_route(routes, start_value, comparator) do
    locations = Map.keys(routes)

    locations
    |> Enum.map(fn start_location ->
      calculate_distance_for_route(
        routes,
        start_value,
        0,
        [start_location],
        Enum.filter(locations, fn x -> x != start_location end),
        comparator
      )
    end)
    |> Enum.filter(&(!is_nil(&1)))
    |> Enum.reduce(start_value, fn acc, x ->
      if comparator.(x, acc) do
        x
      else
        acc
      end
    end)
  end

  @doc """
  Calculates the distance for a route.
  A starting location and a list of locations to visit is required.
  Uses tail call matching with no locations to visit as the terminating
  condition. `nil` is returned when an impossible route is encountered.
  """
  def calculate_distance_for_route(
        _,
        _,
        distance,
        _,
        not_visited,
        _
      )
      when length(not_visited) == 0 do
    # All points visited just return the calculation.
    distance
  end

  def calculate_distance_for_route(
        routes,
        start_value,
        distance,
        visited,
        not_visited,
        comparator
      ) do
    # Get the origin route map and destinations.
    origin_routes = Map.get(routes, List.first(visited))
    origin_routes_keys = Map.keys(origin_routes)

    available_destinations =
      Enum.filter(origin_routes_keys, fn x -> Enum.member?(not_visited, x) end)

    if length(available_destinations) > 0 do
      # There is a destination available and not visited so find
      # the xest.
      [first_destination | other_destinations] = available_destinations

      {xest_distance, xest_origin} =
        other_destinations
        |> Enum.reduce(
          {Map.get(origin_routes, first_destination), first_destination},
          fn x, {chosen_distance, chosen} ->
            x_distance = Map.get(origin_routes, x)

            if comparator.(x_distance, chosen_distance) do
              {x_distance, x}
            else
              {chosen_distance, chosen}
            end
          end
        )

      updated_visited = [xest_origin | visited]

      calculate_distance_for_route(
        routes,
        start_value,
        distance + xest_distance,
        updated_visited,
        Enum.filter(not_visited, fn x -> x != xest_origin end),
        comparator
      )
    else
      # Ended up at a dead end so return nil.
      nil
    end
  end
end
