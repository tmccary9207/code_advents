package logic

import "strconv"

func LookAndSay(input string) string {
	current := rune(input[0])
	current_count := 0
	output := ""

	for _, char := range input {
		if current == char {
			current_count++
		} else {
			output = output + strconv.Itoa(current_count) + string(current)
			current = char
			current_count = 1
		}
	}

	return output + strconv.Itoa(current_count) + string(current)
}

func LookAndSay2(pairs [][]int) [][]int {
	var output [][]int
	carry := pairs[0][0]
	count := 0

	for _, pair := range pairs {
		left := pair[0]
		right := pair[1]
		if carry == left {
			if right == left {
				count = count + 2
			} else {
				output = append(output, []int{count + 1, carry})
				carry = right
				count = 1
			}
		} else {
			output = append(output, []int{count, carry})
			if right == left {
				carry = right
				count = 2
			} else {
				output = append(output, []int{1, left})
				carry = right
				count = 1
			}
		}
	}
	output = append(output, []int{count, carry})

	return output
}
