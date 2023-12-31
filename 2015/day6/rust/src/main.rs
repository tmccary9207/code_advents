use array2d::Array2D;
use regex::Regex;
use std::fs;
use std::usize;

#[derive(PartialEq, Debug)]
struct Instructions {
    action: String,
    from_start: usize,
    from_end: usize,
    to_start: usize,
    to_end: usize,
}

/// Translate input string into instructions.
fn translate_instructions(input: &str) -> Option<Instructions> {
    let re = Regex::new(
        r"(?<action>.*)\s(?<fromStart>\d+)\,(?<fromEnd>\d+).*\s(?<toStart>\d+)\,(?<toEnd>\d+)",
    )
    .unwrap();
    let caps = re.captures(input);

    if caps.is_none() {
        return None;
    }

    let caps = caps.unwrap();

    Some(Instructions {
        action: String::from(caps.name("action").unwrap().as_str()),
        from_start: caps
            .name("fromStart")
            .unwrap()
            .as_str()
            .parse::<usize>()
            .unwrap(),
        from_end: caps
            .name("fromEnd")
            .unwrap()
            .as_str()
            .parse::<usize>()
            .unwrap(),
        to_start: caps
            .name("toStart")
            .unwrap()
            .as_str()
            .parse::<usize>()
            .unwrap(),
        to_end: caps
            .name("toEnd")
            .unwrap()
            .as_str()
            .parse::<usize>()
            .unwrap(),
    })
}

/// Runs all instructions and returns the number of lights that are on.
fn run_instructions(all_input: &str) -> i32 {
    let mut all_lights = Array2D::filled_with(0, 1000, 1000);
    let mut light_count = 0;

    for input in all_input.split("\n") {
        let instructions = translate_instructions(input);
        if instructions.is_none() {
            continue;
        }

        let instructions = instructions.unwrap();
        for x in instructions.from_start..instructions.to_start + 1 {
            for y in instructions.from_end..instructions.to_end + 1 {
                let _ = match instructions.action.as_str() {
                    "turn off" => all_lights.set(x, y, 0),
                    "turn on" => all_lights.set(x, y, 1),
                    _ => {
                        // TOGGLE
                        let state = all_lights.get(x, y).unwrap().clone();
                        match state {
                            1 => all_lights.set(x, y, 0),
                            _ => all_lights.set(x, y, 1),
                        }
                    }
                };
            }
        }
    }

    for row_iter in all_lights.rows_iter() {
        for light in row_iter {
            light_count += light
        }
    }

    light_count
}

/// Runs all instructions and returns the brightness of the light array.
fn run_instructions2(all_input: &str) -> i32 {
    let mut all_lights = Array2D::filled_with(0, 1000, 1000);
    let mut brightness = 0;

    for input in all_input.split("\n") {
        let instructions = translate_instructions(input);
        if instructions.is_none() {
            continue;
        }

        let instructions = instructions.unwrap();
        for x in instructions.from_start..instructions.to_start + 1 {
            for y in instructions.from_end..instructions.to_end + 1 {
                let state = all_lights.get(x, y).unwrap().clone();
                let _ = match instructions.action.as_str() {
                    "turn off" => {
                        let new_state = state - 1;
                        if new_state < 0 {
                            all_lights.set(x, y, 0)
                        } else {
                            all_lights.set(x, y, new_state)
                        }
                    }
                    "turn on" => all_lights.set(x, y, state + 1),
                    _ => all_lights.set(x, y, state + 2),
                };
            }
        }
    }

    for row_iter in all_lights.rows_iter() {
        for light in row_iter {
            brightness += light
        }
    }

    brightness
}

fn main() {
    let text = fs::read_to_string("../myinput.txt").expect("Couldn't read in input file.");
    println!("{} lights are on.", run_instructions(&text));
    println!("{} is the total brightness.", run_instructions2(&text));
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_translate_instructions() {
        assert_eq!(
            translate_instructions("turn on 0,0 through 999,999").unwrap(),
            Instructions {
                action: String::from("turn on"),
                from_start: 0,
                from_end: 0,
                to_start: 999,
                to_end: 999,
            }
        );
        assert_eq!(
            translate_instructions("toggle 0,0 through 999,0").unwrap(),
            Instructions {
                action: String::from("toggle"),
                from_start: 0,
                from_end: 0,
                to_start: 999,
                to_end: 0,
            }
        );
        assert_eq!(
            translate_instructions("turn off 499,499 through 500,500").unwrap(),
            Instructions {
                action: String::from("turn off"),
                from_start: 499,
                from_end: 499,
                to_start: 500,
                to_end: 500,
            }
        );
    }

    #[test]
    fn test_run_instructions() {
        assert_eq!(run_instructions("turn on 0,0 through 999,999\n"), 1000000);
        assert_eq!(run_instructions("toggle 0,0 through 999,0\n"), 1000);
        assert_eq!(
            run_instructions("turn on 0,0 through 999,999\nturn off 499,499 through 500,500\n"),
            999996
        );
    }

    #[test]
    fn test_run_instructions2() {
        assert_eq!(run_instructions2("turn on 0,0 through 999,999\n"), 1000000);
        assert_eq!(run_instructions2("toggle 0,0 through 999,0\n"), 2000);
        assert_eq!(
            run_instructions2("turn on 0,0 through 999,999\nturn off 499,499 through 500,500\n"),
            999996
        );
        assert_eq!(run_instructions2("turn on 0,0 through 0,0\n"), 1);
        assert_eq!(run_instructions2("toggle 0,0 through 999,999\n"), 2000000);
    }
}
