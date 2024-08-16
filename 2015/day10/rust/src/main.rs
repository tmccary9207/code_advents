fn look_and_say(pairs: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
    let mut output = vec![];
    let mut carry = pairs[0][0];
    let mut count = 0;

    for pair in pairs {
        let left = pair[0];
        let right = pair[1];
        if carry == left {
            if right == left {
                count += 2;
            } else {
                output.push(vec![count + 1, carry]);
                carry = right;
                count = 1;
            }
        } else {
            output.push(vec![count, carry]);
            if right == left {
                carry = right;
                count = 2;
            } else {
                output.push(vec![1, left]);
                carry = right;
                count = 1;
            }
        }
    }
    output.push(vec![count, carry]);

    return output
}

fn main() {
    let mut look_and_say_number = vec![vec![1, 1], vec![1, 3], vec![2, 2], vec![2, 1], vec![1, 3]];

    for _ in 0..40 {
        look_and_say_number = look_and_say(look_and_say_number);
    }

    println!("After 40 applications of LookAndSay the length is: {}", look_and_say_number.len() * 2);

    for _ in 0..10 {
        look_and_say_number = look_and_say(look_and_say_number);
    }

    println!("After 50 applications of LookAndSay the length is: {}", look_and_say_number.len() * 2);
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_look_and_say() {
        assert_eq!(
            look_and_say(vec![vec![1, 1]]),
            [[2, 1]]
        );
        assert_eq!(
            look_and_say(vec![vec![2, 1]]),
            [[1, 2], [1, 1]]
        );
        assert_eq!(
            look_and_say(vec![vec![1, 2], vec![1, 1]]),
            [[1, 1], [1, 2], [2, 1]]
        );
        assert_eq!(
            look_and_say(vec![vec![1, 1], vec![1, 2], vec![2, 1]]),
            [[3, 1], [2, 2], [1, 1]]
        );
    }
}
