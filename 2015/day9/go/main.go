package main

import (
	"day9_2015/logic"
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
	parts := make([]logic.Parts, 0, len(lines))
	for _, line := range lines {
		parts = append(parts, logic.LineToParts(line))
	}
	routes := logic.GetRouteMap(parts)
	shortest := logic.GetShortestRoute(routes)
	longest := logic.GetLongestRoute(routes)

	fmt.Printf(
		"Shortest possible distance is: %d\n",
		shortest,
	)
	fmt.Printf(
		"Longest possible distance is: %d\n",
		longest,
	)
}
