use std::{collections::HashMap, fs, vec};

fn line_to_parts<'a>(input: &'a str) -> (&'a str, &'a str, i32) {
    if let [origin, _, destination, __, distance] = input.split(" ").collect::<Vec<_>>().as_slice()
    {
        return (origin, destination, distance.parse::<i32>().unwrap());
    } else {
        return ("", "", 0);
    }
}

fn get_route_map<'a>(
    part_arrays: Vec<(&'a str, &'a str, i32)>,
) -> HashMap<&'a str, HashMap<&'a str, i32>> {
    let mut routes: HashMap<&'a str, HashMap<&'a str, i32>> = HashMap::new();

    part_arrays.iter().for_each(|(x, y, distance)| {
        let mut origin_map = if let Some(om) = routes.get(x) {
            om.clone()
        } else {
            HashMap::new()
        };
        let mut destination_map = if let Some(dm) = routes.get(y) {
            dm.clone()
        } else {
            HashMap::new()
        };
        origin_map.insert(&y, distance.clone());
        destination_map.insert(&x, distance.clone());
        routes.insert(&x, origin_map.clone());
        routes.insert(&y, destination_map.clone());
    });

    return routes;
}

fn shortest_comparator(a: i32, b: i32) -> bool {
    return a < b;
}

fn longest_comparator(a: i32, b: i32) -> bool {
    return a > b;
}

fn get_x_route<'a>(
    routes: HashMap<&'a str, HashMap<&'a str, i32>>,
    starting_value: i32,
    comparator: fn(i32, i32) -> bool,
) -> i32 {
    let locations = routes.keys().collect::<Vec<_>>();
    let number_of_locations = locations.len();
    let number_of_hops = number_of_locations - 1;
    let mut goal = starting_value;

    // Loop over starting locations.
    for start_location in locations {
        let mut distance_for_route = 0;
        let mut visited = vec![start_location];
        for j in 0..number_of_hops {
            let origin = routes.get(visited[j]).unwrap();
            let destinations_not_yet_visited = origin
                .keys()
                .filter(|x| !visited.contains(x))
                .collect::<Vec<_>>();

            if destinations_not_yet_visited.len() < 1 {
                break;
            }

            let (chosen_destination, distance) = destinations_not_yet_visited.iter().fold(
                (
                    destinations_not_yet_visited[0],
                    origin.get(destinations_not_yet_visited[0]).unwrap().clone(),
                ),
                |chosen, x| {
                    let x_distance = origin.get(*x).unwrap().clone();
                    if comparator(x_distance, chosen.1) {
                        (x, x_distance)
                    } else {
                        chosen
                    }
                },
            );

            visited.push(chosen_destination);
            distance_for_route += distance;
        }

        if visited.len() == number_of_locations && comparator(distance_for_route, goal) {
            goal = distance_for_route;
        }
    }

    return goal;
}

fn main() {
    let text = fs::read_to_string("../myinput.txt").expect("Couldn't read in input file.");
    let routes = get_route_map(text.trim_end().split('\n').map(|x| line_to_parts(x)).collect::<Vec<_>>());

    let shortest = get_x_route(routes.clone(), i32::MAX, shortest_comparator);
    let longest = get_x_route(routes, 0, longest_comparator);

    println!("Shortest possible distance is: {}", shortest);
    println!("Longest possible distance is: {}", longest)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_line_to_parts() {
        assert_eq!(
            line_to_parts("London to Dublin = 464"),
            ("London", "Dublin", 464)
        );
    }

    #[test]
    fn test_get_route_map() {
        let example_input =
            "London to Dublin = 464\nLondon to Belfast = 518\nDublin to Belfast = 141";
        let part_arrays = example_input.split("\n").map(line_to_parts).collect();
        let expected = HashMap::from([
            ("Belfast", HashMap::from([("Dublin", 141), ("London", 518)])),
            ("Dublin", HashMap::from([("Belfast", 141), ("London", 464)])),
            ("London", HashMap::from([("Belfast", 518), ("Dublin", 464)])),
        ]);

        assert_eq!(get_route_map(part_arrays), expected);
    }

    #[test]
    fn test_get_x_route() {
        let shortest = get_x_route(
            HashMap::from([
                ("Belfast", HashMap::from([("Dublin", 141), ("London", 518)])),
                ("Dublin", HashMap::from([("Belfast", 141), ("London", 464)])),
                ("London", HashMap::from([("Belfast", 518), ("Dublin", 464)])),
            ]),
            i32::MAX,
            shortest_comparator,
        );

        assert_eq!(shortest, 605);

        let longest = get_x_route(
            HashMap::from([
                ("Belfast", HashMap::from([("Dublin", 141), ("London", 518)])),
                ("Dublin", HashMap::from([("Belfast", 141), ("London", 464)])),
                ("London", HashMap::from([("Belfast", 518), ("Dublin", 464)])),
            ]),
            0,
            longest_comparator,
        );

        assert_eq!(longest, 982);
    }
}
