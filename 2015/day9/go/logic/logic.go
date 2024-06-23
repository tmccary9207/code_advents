package logic

import (
	"slices"
	"strconv"
	"strings"
)

type Parts struct {
	origin      string
	destination string
	distance    uint64
}

func LineToParts(input string) Parts {
	splits := strings.Split(input, " ")
	origin := splits[0]
	destination := splits[2]
	distance, err := strconv.ParseUint(splits[4], 10, 64)

	if err != nil {
		distance = 0
	}

	return Parts{
		origin:      origin,
		destination: destination,
		distance:    distance,
	}
}

type Routemap = map[string]map[string]uint64

func GetRouteMap(partsSlice []Parts) Routemap {
	routes := make(Routemap)
	for _, parts := range partsSlice {
		var originMap map[string]uint64
		var destMap map[string]uint64
		var ok bool

		if originMap, ok = routes[parts.origin]; !ok {
			originMap = make(map[string]uint64)
		}
		if destMap, ok = routes[parts.destination]; !ok {
			destMap = make(map[string]uint64)
		}

		originMap[parts.destination] = parts.distance
		destMap[parts.origin] = parts.distance

		routes[parts.origin] = originMap
		routes[parts.destination] = destMap
	}
	return routes
}

func GetShortestRoute(routes Routemap) uint64 {
	numOfLocations := len(routes)
	locations := make([]string, 0, numOfLocations)
	for k := range routes {
		locations = append(locations, k)
	}

	numberOfHops := len(locations) - 1

	var shortest uint64 = 9223372036854775807

	for i := range locations {
		startLocation := locations[i]
		var visited []string = []string{startLocation}
		var distanceForRoute uint64 = 0

		for j := range numberOfHops {
			origin := routes[visited[j]]

			destinationsNotYetVisited := make([]string, 0)
			for k := range origin {
				already := slices.Contains(visited, k)
				if !already {
					destinationsNotYetVisited = append(destinationsNotYetVisited, k)
				}
			}

			var chosenDestination string
			var chosenDistance uint64 = 9223372036854775807
			for _, x := range destinationsNotYetVisited {
				xDistance := origin[x]
				if xDistance < chosenDistance {
					chosenDestination = x
					chosenDistance = xDistance
				}
			}

			visited = append(visited, chosenDestination)
			distanceForRoute = distanceForRoute + chosenDistance
		}

		if (len(visited) == numOfLocations) && (distanceForRoute < shortest) {
			shortest = distanceForRoute
		}
	}

	return shortest
}

func GetLongestRoute(routes Routemap) uint64 {
	numOfLocations := len(routes)
	locations := make([]string, 0, numOfLocations)
	for k := range routes {
		locations = append(locations, k)
	}

	numberOfHops := len(locations) - 1

	var longest uint64 = 0

	for i := range locations {
		startLocation := locations[i]
		var visited []string = []string{startLocation}
		var distanceForRoute uint64 = 0

		for j := range numberOfHops {
			origin := routes[visited[j]]

			destinationsNotYetVisited := make([]string, 0)
			for k := range origin {
				already := slices.Contains(visited, k)
				if !already {
					destinationsNotYetVisited = append(destinationsNotYetVisited, k)
				}
			}

			var chosenDestination string
			var chosenDistance uint64 = 0
			for _, x := range destinationsNotYetVisited {
				xDistance := origin[x]
				if xDistance > chosenDistance {
					chosenDestination = x
					chosenDistance = xDistance
				}
			}

			visited = append(visited, chosenDestination)
			distanceForRoute = distanceForRoute + chosenDistance
		}

		if (len(visited) == numOfLocations) && (distanceForRoute > longest) {
			longest = distanceForRoute
		}
	}

	return longest
}
