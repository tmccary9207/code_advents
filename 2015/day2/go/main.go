package main

import (
	"day2_2015/calculate"
	"fmt"
	"os"
	"strings"
)

func main() {
	b, err := os.ReadFile("../myinput.txt")
	if err != nil {
		fmt.Println(err)
	}

	str := string(b)
	totalSurfaceArea := 0
	for _, present := range strings.Split(strings.TrimRight(str, "\n"), "\n") {
		totalSurfaceArea += calculate.SurfaceAreaWithSlack(present)
	}

	fmt.Printf("Total square feet of wrapping paper needed: %d\n", totalSurfaceArea)
}
