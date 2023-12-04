package main

import (
	"day1_2015/calculate"
	"fmt"
	"os"
)

func main() {
	b, err := os.ReadFile("../myinput.txt")
	if err != nil {
		fmt.Println(err)
	}

	str := string(b)
	floor := calculate.WhichFloor(str)

	fmt.Printf("Santa ends up on floor: %d\n", floor)
}
