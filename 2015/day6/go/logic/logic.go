package logic

import (
	"regexp"
	"strconv"
	"strings"
)

type instructions struct {
	action    string
	fromStart int
	fromEnd   int
	toStart   int
	toEnd     int
}

// Takes an instructions string and returns an instruction struct.
func TranslateInstructions(instructionsStr string) (instructions, bool) {
	re := regexp.MustCompile(`(?P<action>.*)\s(?P<fromPositionStart>\d+)\,(?P<fromPositionEnd>\d+).*\s(?P<toPositionStart>\d+)\,(?P<toPositionEnd>\d+)`)
	results := instructions{}

	matches := re.FindStringSubmatch(instructionsStr)

	if matches == nil {
		return results, true
	}

	results.action = matches[1]

	val, err := strconv.Atoi(matches[2])

	if err != nil {
		return results, true
	}

	results.fromStart = val

	val, err = strconv.Atoi(matches[3])

	if err != nil {
		return results, true
	}

	results.fromEnd = val

	val, err = strconv.Atoi(matches[4])

	if err != nil {
		return results, true
	}

	results.toStart = val

	val, err = strconv.Atoi(matches[5])

	if err != nil {
		return results, true
	}

	results.toEnd = val

	return results, false
}

// Runs all instructions and reports the number of lights that are on.
func RunInstructions(allInstructions string) int {
	allLights := make([][]int8, 1000)
	for i := range allLights {
		allLights[i] = make([]int8, 1000)
	}

	for _, instructionsStr := range strings.Split(allInstructions, "\n") {
		instructionsStruct, err := TranslateInstructions(instructionsStr)

		if err {
			// Some error happened just go to the next instruction string.
			continue
		}

		for x := instructionsStruct.fromStart; x <= instructionsStruct.toStart; x++ {
			for y := instructionsStruct.fromEnd; y <= instructionsStruct.toEnd; y++ {
				if instructionsStruct.action == "toggle" {
					// Update based on actual state of the light.
					state := allLights[x][y]
					if state == 1 {
						allLights[x][y] = 0
					} else {
						allLights[x][y] = 1
					}
					continue
				}
				if instructionsStruct.action == "turn off" {
					allLights[x][y] = 0
					continue
				}
				allLights[x][y] = 1
			}
		}
	}

	lightCount := 0

	for _, row := range allLights {
		for _, light := range row {
			lightCount += int(light)
		}
	}

	return lightCount
}

// Runs all instructions and reports the brightness of the light array.
func RunInstructions2(allInstructions string) int {
	allLights := make([][]int8, 1000)
	for i := range allLights {
		allLights[i] = make([]int8, 1000)
	}

	for _, instructionsStr := range strings.Split(allInstructions, "\n") {
		instructionsStruct, err := TranslateInstructions(instructionsStr)

		if err {
			// Some error happened just go to the next instruction string.
			continue
		}

		for x := instructionsStruct.fromStart; x <= instructionsStruct.toStart; x++ {
			for y := instructionsStruct.fromEnd; y <= instructionsStruct.toEnd; y++ {
				state := allLights[x][y]
				if instructionsStruct.action == "toggle" {
					// Update based on actual state of the light.
					allLights[x][y] = state + 2
					continue
				}
				if instructionsStruct.action == "turn off" {
          newState := state - 1
          if newState < 0 {
            allLights[x][y] = 0
          } else {
            allLights[x][y] = newState
          }
					continue
				}
				allLights[x][y] = state + 1
			}
		}
	}

	brightness := 0

	for _, row := range allLights {
		for _, light := range row {
			brightness += int(light)
		}
	}

	return brightness
}
