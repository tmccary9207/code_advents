package main

import (
	"day3_2015/mover"
	"fmt"
	"os"
)

func main() {
	b, err := os.ReadFile("../myinput.txt")
	if err != nil {
		fmt.Println(err)
		return
	}

	str := string(b)
	housesVisited := mover.TakeDirections(str)

	fmt.Printf("At least this many houses received a single present: %d", housesVisited)
}
