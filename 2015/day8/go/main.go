package main

import (
	"day8_2015/logic"
	"fmt"
	"os"
	"strings"
)

func main() {
	b, err := os.ReadFile("../myinput.txt")
	if err != nil {
		fmt.Println(err)
		return
	}

	lines := strings.Split(strings.TrimRight(string(b), "\n"), "\n")
	memoryChars := 0
	encodeChars := 0

	for _, line := range lines {
		memoryChars += logic.CountMemoryChars(line)
		encodeChars += logic.CountReencodeStringChars(line)
	}

	fmt.Printf(
		"The number of characters of code for string literals minus the number of characters in memory for the values of the strings is %d.\n",
		memoryChars,
	)
	fmt.Printf(
		"The total number of characters to represent the newly encoded strings minus the number of characters of code in each original string literal is %d.\n",
		encodeChars,
	)
}
