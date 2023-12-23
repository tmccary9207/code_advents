use md5::{Digest, Md5};
use std::i32::MAX;

/**
 * Checks if hash string has five leading zeros.
 */
fn does_hash_have_five_leading_zeros(hash: &str) -> bool {
    let first_five_chars = hash.get(0..5);

    if first_five_chars.is_none() {
        return false;
    }

    first_five_chars.unwrap() == "00000"
}

/**
 * Gets the lowest possible positive integer for the secret key that returns a hash
 * that has five leading zeros.
 */
fn get_lowest_number(secret_key: &str) -> i32 {
    let mut lowest_number = 0;

    while lowest_number < MAX {
        let mut hasher = Md5::new();

        hasher.update(format!("{}{}", secret_key, lowest_number).as_bytes());

        let md5_result = hasher.finalize();

        if does_hash_have_five_leading_zeros(&format!("{:x}", md5_result)) {
            break
        }

        lowest_number = lowest_number + 1
    }

    lowest_number
}

fn main() {
    println!("The lowest number that will create an adventcoin with our key is: {}", get_lowest_number("bgvyzdsv"))
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_does_hash_have_five_leading_zeros() {
        assert_eq!(does_hash_have_five_leading_zeros("000001"), true);
        assert_eq!(does_hash_have_five_leading_zeros("000011"), false);
    }

    #[test]
    fn test_get_lowest_number() {
        assert_eq!(get_lowest_number("abcdef"), 609043);
        assert_eq!(get_lowest_number("pqrstuv"), 1048970);
    }
}
