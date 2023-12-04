package calculate

// A function to find out which floor Santa is on.
func WhichFloor(input string) int {
	tally := 0
	for _, char := range input {
		switch char {
		case '(':
			tally++
		case ')':
			tally--
		}
	}
	return tally
}
