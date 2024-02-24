use regex::Regex;
use std::collections::HashMap;
use std::fs;

#[derive(PartialEq, Debug, Clone)]
struct Wire {
    action: String,
    numerical_args: Vec<u16>,
    named_args: Vec<String>,
}

fn line_to_label_and_wire(input: &str) -> (String, Wire) {
    let action_regex = Regex::new(r"[A-Z]+").unwrap();
    let numerical_args_regex = Regex::new(r"[0-9]+").unwrap();
    let named_args_regex = Regex::new(r"[a-z]+").unwrap();
    let (ops, key) = input
        .split_once(" -> ")
        .expect("Wire line should have a -> in it.");
    let action = if let Some(x) = action_regex.find(ops) {
        x.as_str().to_string()
    } else {
        String::from("")
    };
    let numerical_args = numerical_args_regex
        .find_iter(ops)
        .map(|x| {
            x.as_str()
                .parse::<u16>()
                .expect("Should be a numerical argument.")
        })
        .collect();
    let named_args = named_args_regex
        .find_iter(ops)
        .map(|x| x.as_str().to_string())
        .collect();

    (
        key.to_string(),
        Wire {
            action,
            numerical_args,
            named_args,
        },
    )
}

fn parse(input: String) -> Vec<(String, Wire)> {
    input
        .strip_suffix("\n")
        .expect("This program only handles unix style line breaks, sorry.")
        .split("\n")
        .map(line_to_label_and_wire)
        .collect()
}

fn all_named_args_present(wire: &Wire, calculations: &HashMap<String, u16>) -> bool {
    wire.named_args.iter().all(|x| calculations.contains_key(x))
}

fn get_value_for_wire(wire: &Wire, calculations: &HashMap<String, u16>) -> u16 {
    let mut values: Vec<u16> = wire
        .named_args
        .iter()
        .map(|x| calculations.get(x).unwrap().clone())
        .collect();
    wire.numerical_args
        .iter()
        .for_each(|x| values.push(x.clone()));

    match wire.action.as_str() {
        "AND" => values
            .iter()
            .fold(values.first().unwrap().clone(), |acc, e| acc & e),
        "OR" => values
            .iter()
            .fold(values.first().unwrap().clone(), |acc, e| acc | e),
        "NOT" => !values.first().unwrap().clone(),
        "LSHIFT" => values.get(0).unwrap().clone() << values.get(1).unwrap().clone(),
        "RSHIFT" => values.get(0).unwrap().clone() >> values.get(1).unwrap().clone(),
        _ => values.first().unwrap().clone(),
    }
}

fn override_wire(instructions: &mut Vec<(String, Wire)>, value: u16) {
    for x in instructions {
        if x.0 == "b" {
            x.1 = Wire {
                action: String::from(""),
                numerical_args: vec![value],
                named_args: vec![],
            }
        }
    }
}

fn run_instructions(instructions: Vec<(String, Wire)>, target: &str) -> u16 {
    let mut calculations: HashMap<String, u16> = HashMap::new();
    let mut local_instructions = instructions;

    while !calculations.contains_key(target) {
        local_instructions = local_instructions
            .into_iter()
            .filter(|(label, wire)| {
                if !all_named_args_present(wire, &calculations) {
                    return true;
                }

                calculations.insert(label.to_string(), get_value_for_wire(wire, &calculations));

                return false;
            })
            .collect();
    }

    calculations.get(target).unwrap().clone()
}

fn main() {
    let text = fs::read_to_string("../myinput.txt").expect("Couldn't read in input file.");
    let mut wires = parse(text);

    let result_one = run_instructions(wires.to_vec(), "a");

    override_wire(&mut wires, result_one);

    println!("Wire A's value is {}.", result_one);
    println!("Wire A's value when B is overridden with {} is {}.", result_one, run_instructions(wires, "a"))
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_line_to_wire() {
        assert_eq!(
            line_to_label_and_wire("lf AND lq -> ls"),
            (
                String::from("ls"),
                Wire {
                    action: String::from("AND"),
                    numerical_args: vec![],
                    named_args: vec![String::from("lf"), String::from("lq")],
                }
            )
        );
        assert_eq!(
            line_to_label_and_wire("iu RSHIFT 1 -> jn"),
            (
                String::from("jn"),
                Wire {
                    action: String::from("RSHIFT"),
                    numerical_args: vec![1],
                    named_args: vec![String::from("iu")],
                }
            )
        );
        assert_eq!(
            line_to_label_and_wire("NOT kt -> ku"),
            (
                String::from("ku"),
                Wire {
                    action: String::from("NOT"),
                    numerical_args: vec![],
                    named_args: vec![String::from("kt")],
                }
            )
        );
        assert_eq!(
            line_to_label_and_wire("1 -> x"),
            (
                String::from("x"),
                Wire {
                    action: String::from(""),
                    numerical_args: vec![1],
                    named_args: vec![],
                }
            )
        );
    }

    #[test]
    fn test_parse() {
        assert_eq!(
            parse(String::from(
                "lf AND lq -> ls\niu RSHIFT 1 -> jn\nNOT kt -> ku\n1 -> x\n"
            )),
            vec![
                (
                    String::from("ls"),
                    Wire {
                        action: String::from("AND"),
                        numerical_args: vec![],
                        named_args: vec![String::from("lf"), String::from("lq")],
                    }
                ),
                (
                    String::from("jn"),
                    Wire {
                        action: String::from("RSHIFT"),
                        numerical_args: vec![1],
                        named_args: vec![String::from("iu")],
                    }
                ),
                (
                    String::from("ku"),
                    Wire {
                        action: String::from("NOT"),
                        numerical_args: vec![],
                        named_args: vec![String::from("kt")],
                    }
                ),
                (
                    String::from("x"),
                    Wire {
                        action: String::from(""),
                        numerical_args: vec![1],
                        named_args: vec![],
                    }
                ),
            ]
        );
    }

    #[test]
    fn test_all_named_args_present() {
        let mut calculations = HashMap::new();
        calculations.insert("x".to_string(), 1);

        assert_eq!(
            all_named_args_present(
                &Wire {
                    action: String::from("AND"),
                    numerical_args: vec![],
                    named_args: vec![String::from("lf"), String::from("lq")],
                },
                &calculations
            ),
            false
        );

        assert_eq!(
            all_named_args_present(
                &Wire {
                    action: String::from("AND"),
                    numerical_args: vec![],
                    named_args: vec![String::from("x")],
                },
                &calculations
            ),
            true
        );

        assert_eq!(
            all_named_args_present(
                &Wire {
                    action: String::from("AND"),
                    numerical_args: vec![1, 2],
                    named_args: vec![],
                },
                &calculations
            ),
            true
        );
    }

    #[test]
    fn test_get_value_for_wire() {
        let mut calculations = HashMap::new();
        calculations.insert("x".to_string(), 123);
        calculations.insert("y".to_string(), 456);

        assert_eq!(
            get_value_for_wire(
                &Wire {
                    action: String::from("AND"),
                    numerical_args: vec![],
                    named_args: vec![String::from("x"), String::from("y")],
                },
                &calculations
            ),
            72
        );

        assert_eq!(
            get_value_for_wire(
                &Wire {
                    action: String::from("OR"),
                    numerical_args: vec![],
                    named_args: vec![String::from("x"), String::from("y")],
                },
                &calculations
            ),
            507
        );

        assert_eq!(
            get_value_for_wire(
                &Wire {
                    action: String::from("LSHIFT"),
                    numerical_args: vec![2],
                    named_args: vec![String::from("x")],
                },
                &calculations
            ),
            492
        );

        assert_eq!(
            get_value_for_wire(
                &Wire {
                    action: String::from("RSHIFT"),
                    numerical_args: vec![2],
                    named_args: vec![String::from("y")],
                },
                &calculations
            ),
            114
        );

        assert_eq!(
            get_value_for_wire(
                &Wire {
                    action: String::from("NOT"),
                    numerical_args: vec![],
                    named_args: vec![String::from("x")],
                },
                &calculations
            ),
            65412
        );

        assert_eq!(
            get_value_for_wire(
                &Wire {
                    action: String::from(""),
                    numerical_args: vec![],
                    named_args: vec![String::from("x")],
                },
                &calculations
            ),
            123
        );
    }
}
