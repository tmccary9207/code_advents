use regex::Regex;
use std::fs;

/**
 * Checks if there are three or more vowels in a string.
 */
fn has_three_or_more_vowels(datum: &str) -> bool {
    let re = Regex::new(r"[aeiou]").unwrap();
    let count = re.captures_iter(datum).count();
    count > 2
}

/**
 * Checks if there is a pair of letters repeated in a string.
 */
fn has_same_letter_pair(datum: &str) -> bool {
    let mut last_char = '\0';
    let mut has_pair = false;

    for char in datum.chars() {
        if last_char == char {
            has_pair = true;
            break;
        }
        last_char = char;
    }

    has_pair
}

/**
 * Checks if there is any naughty strings in the string.
 */
fn has_no_naughty_strings(datum: &str) -> bool {
    let re = Regex::new(r"(ab)|(cd)|(pq)|(xy)").unwrap();
    let count = re.captures_iter(datum).count();
    count < 1
}

/**
 * Checks if string is nice.
 * @param {string} datum String to check.
 */
fn is_string_nice(datum: &str) -> bool {
    has_three_or_more_vowels(datum) && has_no_naughty_strings(datum) && has_same_letter_pair(datum)
}

fn main() {
    let text = fs::read_to_string("../myinput.txt").expect("Couldn't read in input file.");
    let nice_string_count = text
        .split("\n")
        .filter(|x| -> bool { is_string_nice(x) })
        .count();
    println!("{} nice strings.", nice_string_count)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_has_three_or_more_vowels() {
        assert_eq!(has_three_or_more_vowels("aei"), true);
        assert_eq!(has_three_or_more_vowels("xazegov"), true);
        assert_eq!(has_three_or_more_vowels("aeiouaeiouaeiou"), true);
        assert_eq!(has_three_or_more_vowels("ugknbfddgicrmopn"), true);
        assert_eq!(has_three_or_more_vowels("aaa"), true);
        assert_eq!(has_three_or_more_vowels("jchzalrnumimnmhp"), true);
        assert_eq!(has_three_or_more_vowels("haegwjzuvuyypxyu"), true);
        assert_eq!(has_three_or_more_vowels("dvszwmarrgswjxmb"), false);
    }

    #[test]
    fn test_has_same_letter_pair() {
        assert_eq!(has_same_letter_pair("xx"), true);
        assert_eq!(has_same_letter_pair("abcdde"), true);
        assert_eq!(has_same_letter_pair("aabbccdd"), true);
        assert_eq!(has_same_letter_pair("ugknbfddgicrmopn"), true);
        assert_eq!(has_same_letter_pair("aaa"), true);
        assert_eq!(has_same_letter_pair("jchzalrnumimnmhp"), false);
        assert_eq!(has_same_letter_pair("haegwjzuvuyypxyu"), true);
        assert_eq!(has_same_letter_pair("dvszwmarrgswjxmb"), true);
    }

    #[test]
    fn test_has_no_naughty_strings() {
        assert_eq!(has_no_naughty_strings("xx"), true);
        assert_eq!(has_no_naughty_strings("abcdde"), false);
        assert_eq!(has_no_naughty_strings("aabbccdd"), false);
        assert_eq!(has_no_naughty_strings("ugknbfddgicrmopn"), true);
        assert_eq!(has_no_naughty_strings("aaa"), true);
        assert_eq!(has_no_naughty_strings("jchzalrnumimnmhp"), true);
        assert_eq!(has_no_naughty_strings("haegwjzuvuyypxyu"), false);
        assert_eq!(has_no_naughty_strings("dvszwmarrgswjxmb"), true);
    }

    #[test]
    fn test_is_string_nice() {
        assert_eq!(is_string_nice("xx"), false);
        assert_eq!(is_string_nice("abcdde"), false);
        assert_eq!(is_string_nice("aabbccdd"), false);
        assert_eq!(is_string_nice("ugknbfddgicrmopn"), true);
        assert_eq!(is_string_nice("aaa"), true);
        assert_eq!(is_string_nice("jchzalrnumimnmhp"), false);
        assert_eq!(is_string_nice("haegwjzuvuyypxyu"), false);
        assert_eq!(is_string_nice("dvszwmarrgswjxmb"), false);
    }
}
