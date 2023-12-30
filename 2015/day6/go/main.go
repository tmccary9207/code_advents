package main

import (
	"day6_2015/logic"
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

  lightCount := logic.RunInstructions(str)
  fmt.Printf("%d lights are on.\n", lightCount)

  brightness := logic.RunInstructions2(str)
  fmt.Printf("%d is the total brightness.", brightness)
}
