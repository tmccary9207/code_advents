package main

import (
	"day7_2015/logic"
	"fmt"
	"os"
)

type WireOperation = logic.WireOperation

func main() {
	b, err := os.ReadFile("../myinput.txt")
	if err != nil {
		fmt.Println(err)
		return
	}

	str := string(b)

	wire_a_value := logic.RunInstructions(str, "a")
	fmt.Printf("Wire A's value is %d.\n", wire_a_value)

	new_wire_a_value := logic.RunInstructions2(
		str,
		"a",
		"b",
		WireOperation{
			Operation:     "",
			NamedArgs:     []string{},
			NumericalArgs: []uint64{wire_a_value},
		},
	)
	fmt.Printf("Wire A's value when B is overridden with %d is %d.\n", wire_a_value, new_wire_a_value)
}
