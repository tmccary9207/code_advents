use std::char;
use std::collections::HashSet;
use std::fs;

/**
 * Gets the new locaiton for Santa.
 */
fn new_location(current_location: [i32; 2], direction: char) -> [i32; 2] {
    match direction {
        '^' => [current_location[0], current_location[1] + 1],
        'v' => [current_location[0], current_location[1] - 1],
        '>' => [current_location[0] + 1, current_location[1]],
        '<' => [current_location[0] - 1, current_location[1]],
        _ => current_location
    }
}

/**
 * Takes directions from an elf and returns the unique number of houses visted.
 */
fn take_directions(directions: &str) -> usize {
    let mut visited = HashSet::from(["0,0".to_string()]);
    let mut current_location = [0,0];

    directions.chars().for_each(|direction| {
        current_location = new_location(current_location, direction);
        visited.insert(
            format!("{},{}", current_location[0], current_location[1])
        );
    });

    visited.len()
}

fn main() {
    let text = fs::read_to_string("../myinput.txt")
        .expect("Couldn't read in input file.");
    let houses_visited = take_directions(&text);
    println!("At least this many houses received a single present: {}", houses_visited)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_new_location() {
        assert_eq!(new_location([0, 0], '^'), [0, 1]);
        assert_eq!(new_location([0, 0], 'v'), [0, -1]);
        assert_eq!(new_location([0, 0], '>'), [1, 0]);
        assert_eq!(new_location([0, 0], '<'), [-1, 0]);
    }

    #[test]
    fn test_take_directions() {
        assert_eq!(take_directions(">"), 2);
        assert_eq!(take_directions("^>v<"), 4);
        assert_eq!(take_directions("^v^v^v^v^v"), 2);
    }
}
