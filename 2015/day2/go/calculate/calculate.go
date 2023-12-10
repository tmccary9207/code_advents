package calculate

import (
	"fmt"
	"slices"
)

// Calculate the surface area of the present.
func SurfaceArea(sides []int) int {
	tally := 0
	for _, side := range sides {
		tally += (side * 2)
	}
	return tally
}

// Calculate the surface area plus slack for a present.
func SurfaceAreaWithSlack(input string) int {
	var length, width, height int
	_, error := fmt.Sscanf(input, "%dx%dx%d", &length, &width, &height)
	if error != nil {
		fmt.Println(error)
		return 0
	}
	sides := []int{(length * width), (width * height), (height * length)}
	return SurfaceArea(sides) + slices.Min(sides)
}
