use std::fs;

/**
 * Calculate the surface area of the present.
 */
fn surface_area(sides: [i32; 3]) -> i32 {
    sides.iter().fold(0, |tally, x| {
        tally + (x * 2)
    })
}

/**
 * Calculate the surface area of the present with slack.
 */
fn surface_area_with_slack(input: &str) -> i32 {
    let values = input
        .split("x")
        .map(|x| x.parse::<i32>().expect("Parsable Number."))
        .collect::<Vec<i32>>();
    if let [length, width, height] = &values[0..3] {
        let sides = [(length * width), (width * height), (height * length)];
        surface_area(sides) + sides.iter().min().expect("Iter was empty.")
    } else {
        0
    }
}

fn main() {
    let text = fs::read_to_string("../myinput.txt")
        .expect("Couldn't read in input file.");
    let total_surface_area = text.trim().split("\n").fold(0, |tally, present| {
        tally + surface_area_with_slack(present)
    });
    println!("Total square feet of wrapping paper needed: {}", total_surface_area)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_surface_area() {
        assert_eq!(surface_area([6, 12, 8]), 52);
        assert_eq!(surface_area([1, 10, 10]), 42);
    }

    #[test]
    fn test_surface_area_with_slack() {
        assert_eq!(surface_area([6, 12, 8]), 52);
        assert_eq!(surface_area([1, 10, 10]), 42);
    }
}
