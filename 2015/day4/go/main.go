package main

import (
	"day4_2015/logic"
	"fmt"
)

func main() {
  lowestNumber := logic.GetLowestNumber("bgvyzdsv")

	fmt.Printf("The lowest number that will create an adventcoin with our key is: %d", lowestNumber)
}

