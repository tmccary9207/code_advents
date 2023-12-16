package mover

import (
	"fmt"
	mapset "github.com/deckarep/golang-set/v2"
)

// Get the new location for Santa.
func NewLocation(current_location []int, direction rune) []int {
	switch direction {
	case '^':
		return []int{current_location[0], current_location[1] + 1}
	case 'v':
		return []int{current_location[0], current_location[1] - 1}
	case '>':
		return []int{current_location[0] + 1, current_location[1]}
	case '<':
		return []int{current_location[0] - 1, current_location[1]}
	default:
		return current_location
	}
}

// Takes in directions from an elf and returns the number of unique houses Santa visited.
func TakeDirections(directions string) int {
	visited := mapset.NewSet[string]()
	visited.Add("0,0")
	current_location := []int{0, 0}
	for _, direction := range directions {
		current_location = NewLocation(current_location, direction)
		visited.Add(fmt.Sprintf("%d,%d", current_location[0], current_location[1]))
	}
	return visited.Cardinality()
}
