package main

import (
	"day10_2015/logic"
	"fmt"
)

func main() {
	// look_and_say_number := "1113222113"
	look_and_say_number := [][]int{{1, 1}, {1, 3}, {2, 2}, {2, 1}, {1, 3}}

	for range 40 {
		look_and_say_number = logic.LookAndSay2(look_and_say_number)
	}

	fmt.Printf(
		"After 40 applications of LookAndSay the length is: %d\n",
		len(look_and_say_number)*2,
	)

	for range 10 {
		look_and_say_number = logic.LookAndSay2(look_and_say_number)
	}

	fmt.Printf(
		"After 50 applications of LookAndSay the length is: %d\n",
		len(look_and_say_number)*2,
	)
}
