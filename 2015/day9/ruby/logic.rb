def line_to_parts(line)
    origin, _, destination, __, distance = line.split(' ')
    [origin, destination, distance.to_i()]
end

def get_route_map(parts)
    routes = {}

    parts.each do |part|
        origin, destination, distance = part
        origin_map = routes[origin] || {}
        destination_map = routes[destination] || {}
        origin_map[destination] = distance
        destination_map[origin] = distance
        routes[origin] = origin_map
        routes[destination] = destination_map
    end

    routes
end

def get_shortest_route(routes)
    locations = routes.keys
    number_of_hops = locations.length - 1
    shortest = 1 << 64

    locations.each do |start_location|
        distance_for_route = 0
        visited = [start_location]

        (0..number_of_hops).to_a.each do ||
            origin = routes[visited[-1]]
            destinations_not_yet_visited = origin.keys().filter { |x| !visited.include?(x) }
            if destinations_not_yet_visited.length < 1
                next
            end

            chosen = destinations_not_yet_visited[0]
            chosen_distance = origin[chosen]

            destinations_not_yet_visited.each do |x|
                x_distance = origin[x]
                if x_distance < chosen_distance
                    chosen = x
                    chosen_distance = x_distance
                end
            end

            visited.append(chosen)
            distance_for_route += chosen_distance
        end

        if visited.length == locations.length and distance_for_route < shortest
            shortest = distance_for_route
        end
    end

    shortest
end

def get_longest_route(routes)
    locations = routes.keys
    number_of_hops = locations.length - 1
    longest = 0

    locations.each do |start_location|
        distance_for_route = 0
        visited = [start_location]

        (0..number_of_hops).to_a.each do ||
            origin = routes[visited[-1]]
            destinations_not_yet_visited = origin.keys().filter { |x| !visited.include?(x) }
            if destinations_not_yet_visited.length < 1
                next
            end

            chosen = destinations_not_yet_visited[0]
            chosen_distance = origin[chosen]

            destinations_not_yet_visited.each do |x|
                x_distance = origin[x]
                if x_distance > chosen_distance
                    chosen = x
                    chosen_distance = x_distance
                end
            end

            visited.append(chosen)
            distance_for_route += chosen_distance
        end

        if visited.length == locations.length and distance_for_route > longest
            longest = distance_for_route
        end
    end

    longest
end