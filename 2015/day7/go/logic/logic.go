package logic

import (
	"regexp"
	"strconv"
	"strings"
)

type WireOperation struct {
	Operation     string
	NamedArgs     []string
	NumericalArgs []uint64
}

var operationRegex = regexp.MustCompile(`[A-Z]+`)
var namedArgsRegex = regexp.MustCompile(`[a-z]+`)
var numericalArgs = regexp.MustCompile(`[0-9]+`)

func parse(input string) map[string]WireOperation {
	result := make(map[string]WireOperation)

	lines := strings.Split(input, "\n")

	for _, line := range lines {
		parts := strings.Split(line, " -> ")
		if len(parts) < 2 {
			continue
		}
		rawOperation, key := parts[0], parts[1]
		operation := operationRegex.FindString(rawOperation)
		namedArgs := namedArgsRegex.FindAllString(rawOperation, -1)
		numericalArgsTmp := numericalArgs.FindAllString(rawOperation, -1)

		var numericalArgs []uint64
		for _, arg := range numericalArgsTmp {
			if nArg, err := strconv.ParseUint(arg, 10, 64); err == nil {
				numericalArgs = append(numericalArgs, nArg)
			}
		}

		result[key] = WireOperation{Operation: operation, NamedArgs: namedArgs, NumericalArgs: numericalArgs}
	}

	return result
}

func isOperationDoable(calculatedValues map[string]uint64, operation WireOperation) bool {
	if len(operation.NamedArgs) < 1 {
		return true
	}
	for _, arg := range operation.NamedArgs {
		if _, exists := calculatedValues[arg]; !exists {
			return false
		}
	}
	return true
}

func getArgsForOperation(calculatedValues map[string]uint64, wireOperation WireOperation) []uint64 {
	var args []uint64
	for _, arg := range wireOperation.NamedArgs {
		val, _ := calculatedValues[arg]
		args = append(args, val)
	}
	return append(args, wireOperation.NumericalArgs...)
}

func handleAndOperation(args []uint64) uint64 {
	return args[0] & args[1]
}

func handleOrOperation(args []uint64) uint64 {
	return args[0] | args[1]
}

func handleNotOperation(args []uint64) uint64 {
	return (^args[0]) & 0xF
}

func handleLShiftOperation(args []uint64) uint64 {
	return args[0] << args[1]
}

func handleRShiftOperation(args []uint64) uint64 {
	return args[0] >> args[1]
}

func doOperation(calculatedValues map[string]uint64, wireOperation WireOperation) uint64 {
	args := getArgsForOperation(calculatedValues, wireOperation)
	switch wireOperation.Operation {
	case "AND":
		return handleAndOperation(args)
	case "OR":
		return handleOrOperation(args)
	case "NOT":
		return handleNotOperation(args)
	case "LSHIFT":
		return handleLShiftOperation(args)
	case "RSHIFT":
		return handleRShiftOperation(args)
	default:
		return args[0]
	}
}

func RunInstructions(input string, targetWire string) uint64 {
	wires := parse(input)
	calculatedValues := make(map[string]uint64)

	for {
		if value, exists := calculatedValues[targetWire]; exists {
			return value
		}

		for label, operation := range wires {
			if !isOperationDoable(calculatedValues, operation) {
				continue
			}
			calculatedValues[label] = doOperation(calculatedValues, operation)
			delete(wires, label)
		}
	}
}

func RunInstructions2(input string, targetWire string, overrideLabel string, override WireOperation) uint64 {
	wires := parse(input)
	wires[overrideLabel] = override
	calculatedValues := make(map[string]uint64)

	for {
		if value, exists := calculatedValues[targetWire]; exists {
			return value
		}

		for label, operation := range wires {
			if !isOperationDoable(calculatedValues, operation) {
				continue
			}
			calculatedValues[label] = doOperation(calculatedValues, operation)
			delete(wires, label)
		}
	}
}
