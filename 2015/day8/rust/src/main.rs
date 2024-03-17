use regex::Regex;
use std::fs;

fn count_memory_chars(input: &str) -> usize {
    let no_quotes = input.trim_matches('"');

    let two_letter_regex = Regex::new(r#"(\\")|(\\\\)"#).unwrap();
    let four_letter_regex = Regex::new(r#"(\\x[0-9|a-f|A-F]{2})"#).unwrap();

    let two_letter_count = two_letter_regex.find_iter(no_quotes).count();
    let four_letter_count = four_letter_regex.find_iter(no_quotes).count();

    input.chars().count()
        - (no_quotes.chars().count() - (two_letter_count + (3 * four_letter_count)))
}

fn count_reencode_string_chars(input: &str) -> usize {
    let escaped_slash_regex = Regex::new(r#"(\\)"#).unwrap();
    let escaped_quotes_regex = Regex::new(r#"(")"#).unwrap();

    let escaped_slash_count = escaped_slash_regex.find_iter(input).count();
    let escaped_quotes_count = escaped_quotes_regex.find_iter(input).count() - 2;

    (escaped_slash_count + escaped_quotes_count) + 4
}

fn main() {
    let text = fs::read_to_string("../myinput.txt").expect("Couldn't read in input file.");
    let lines = text
        .strip_suffix("\n")
        .expect("This program only handles unix style line breaks, sorry.")
        .split("\n");
    let mut memory_chars = 0;
    let mut reencode_chars = 0;

    for line in lines {
        memory_chars += count_memory_chars(line);
        reencode_chars += count_reencode_string_chars(line);
    }

    println!(
        "The number of characters of code for string literals minus the number of characters in memory for the values of the strings is {}.",
        memory_chars
    );
    println!(
        "The total number of characters to represent the newly encoded strings minus the number of characters of code in each original string literal is {}.",
        reencode_chars
    );
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_count_memory_chars() {
        assert_eq!(count_memory_chars(r#""""#), 2);
        assert_eq!(count_memory_chars(r#""abc""#), 2);
        assert_eq!(count_memory_chars(r#""aaa\"aaa""#), 3);
        assert_eq!(count_memory_chars(r#""\x27""#), 5);
        assert_eq!(count_memory_chars(r#""xrgcripdu\x4c\xc4gszjhrvumvz\"mngbirb""#), 9);
    }

    #[test]
    fn test_count_reencode_string_chars() {
        assert_eq!(count_reencode_string_chars(r#""""#), 4);
        assert_eq!(count_reencode_string_chars(r#""abc""#), 4);
        assert_eq!(count_reencode_string_chars(r#""aaa\"aaa""#), 6);
        assert_eq!(count_reencode_string_chars(r#""\x27""#), 5);
    }
}
