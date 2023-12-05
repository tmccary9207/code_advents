use std::fs;

/**
 * Get which floor Santa is on.
 */
fn which_floor(input: &str) -> i32 {
    input.chars().fold(0, |tally, x| {
        match x {
            '(' => tally + 1,
            ')' => tally - 1,
            _ => tally
        }
    })
}

fn main() {
    let text = fs::read_to_string("../myinput.txt")
        .expect("Couldn't read in input file.");
    let floor = which_floor(&text);
    println!("Santa ends up on floor: {}", floor);
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_which_floor() {
        assert_eq!(which_floor("(())"), 0);
        assert_eq!(which_floor("()()"), 0);
        assert_eq!(which_floor("((("), 3);
        assert_eq!(which_floor("(()(()("), 3);
        assert_eq!(which_floor("))((((("), 3);
        assert_eq!(which_floor("())"), -1);
        assert_eq!(which_floor("))("), -1);
        assert_eq!(which_floor(")))"), -3);
        assert_eq!(which_floor(")())())"), -3);
    }
}
