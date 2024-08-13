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
