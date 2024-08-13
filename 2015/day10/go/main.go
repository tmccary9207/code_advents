package main

import (
	"day10_2015/logic"
	"fmt"
)

func main() {
	look_and_say_number := "1113222113"

	for range 40 {
		look_and_say_number = logic.LookAndSay(look_and_say_number)
	}

	fmt.Printf(
		"After 40 applications of LookAndSay the length is: %d\n",
		len(look_and_say_number),
	)

	for range 10 {
		look_and_say_number = logic.LookAndSay(look_and_say_number)
	}

	fmt.Printf(
		"After 50 applications of LookAndSay the length is: %d\n",
		len(look_and_say_number),
	)
}
