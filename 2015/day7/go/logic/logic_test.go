package logic

import (
	"fmt"
	"testing"
)

func TestParse(t *testing.T) {
	in := "123 -> x\n456 -> y\nx AND y -> d\nx OR y -> e\nx LSHIFT 2 -> f\ny RSHIFT 2 -> g\nNOT x -> h\nNOT y -> i"
	want := map[string]WireOperation{
		"x": {Operation: "", NamedArgs: []string{}, NumericalArgs: []uint64{123}},
		"y": {Operation: "", NamedArgs: []string{}, NumericalArgs: []uint64{456}},
		"d": {Operation: "AND", NamedArgs: []string{"x", "y"}, NumericalArgs: []uint64{}},
		"e": {Operation: "OR", NamedArgs: []string{"x", "y"}, NumericalArgs: []uint64{}},
		"f": {Operation: "LSHIFT", NamedArgs: []string{"x"}, NumericalArgs: []uint64{2}},
		"g": {Operation: "RSHIFT", NamedArgs: []string{"y"}, NumericalArgs: []uint64{2}},
		"h": {Operation: "NOT", NamedArgs: []string{"x"}, NumericalArgs: []uint64{}},
		"i": {Operation: "NOT", NamedArgs: []string{"y"}, NumericalArgs: []uint64{}},
	}
	got := parse(in)
	if fmt.Sprint(want) != fmt.Sprint(got) {
		t.Errorf("parse(%v) == %v, want %v", in, got, want)
	}
}

func TestIsOperationDoable(t *testing.T) {
	calculatedValues := map[string]uint64{"x": 1}
	cases := []struct {
		in   WireOperation
		want bool
	}{
		{WireOperation{Operation: "", NamedArgs: []string{"x"}, NumericalArgs: []uint64{}}, true},
		{WireOperation{Operation: "", NamedArgs: []string{}, NumericalArgs: []uint64{1}}, true},
		{WireOperation{Operation: "", NamedArgs: []string{"y"}, NumericalArgs: []uint64{}}, false},
	}

	for _, c := range cases {
		got := isOperationDoable(calculatedValues, c.in)
		if got != c.want {
			t.Errorf("isOperationDoable(%v) == %v, want %v", c.in, got, c.want)
		}
	}
}

func TestGetArgsForOperation(t *testing.T) {
	in_one := map[string]uint64{"x": 1}
	in_two := WireOperation{Operation: "", NamedArgs: []string{"x"}, NumericalArgs: []uint64{2}}
	want := []uint64{1, 2}
	got := getArgsForOperation(in_one, in_two)
	if fmt.Sprint(want) != fmt.Sprint(got) {
		t.Errorf("getArgsForOperation(%v, %v) == %v, want %v", in_one, in_two, got, want)
	}
}

func TestHandleAndOperation(t *testing.T) {
	in := []uint64{5, 3}
	want := uint64(1)
	got := handleAndOperation(in)
	if want != got {
		t.Errorf("handleAndOperation(%v) == %v, want %v", in, got, want)
	}
}

func TestHandleOrOperation(t *testing.T) {
	in := []uint64{5, 3}
	want := uint64(7)
	got := handleOrOperation(in)
	if want != got {
		t.Errorf("handleOrOperation(%v) == %v, want %v", in, got, want)
	}
}

func TestHandleNotOperation(t *testing.T) {
	in := []uint64{7}
	want := uint64(8)
	got := handleNotOperation(in)
	if want != got {
		t.Errorf("handleNotOperation(%v) == %v, want %v", in, got, want)
	}
}

func TestHandleLShiftOperation(t *testing.T) {
	in := []uint64{23, 1}
	want := uint64(46)
	got := handleLShiftOperation(in)
	if want != got {
		t.Errorf("handleLShiftOperation(%v) == %v, want %v", in, got, want)
	}
}

func TestHandleRShiftOperation(t *testing.T) {
	in := []uint64{23, 1}
	want := uint64(11)
	got := handleRShiftOperation(in)
	if want != got {
		t.Errorf("handleRShiftOperation(%v) == %v, want %v", in, got, want)
	}
}

func TestDoOperation(t *testing.T) {
	in_one := map[string]uint64{"x": 23}
	in_two := WireOperation{Operation: "LSHIFT", NamedArgs: []string{"x"}, NumericalArgs: []uint64{1}}
	want := uint64(46)
	got := doOperation(in_one, in_two)
	if want != got {
		t.Errorf("doOperation(%v, %v) == %v, want %v", in_one, in_two, got, want)
	}
}

func TestRunInstructions(t *testing.T) {
	in_one := "123 -> x\n456 -> y\nx AND y -> d\nx OR y -> e\nx LSHIFT 2 -> f\ny RSHIFT 2 -> g\nNOT x -> h\nNOT y -> i"
	in_two := "d"
	want := uint64(72)
	got := RunInstructions(in_one, in_two)
	if want != got {
		t.Errorf("RunInstructions(%v, %v) == %v, want %v", in_one, in_two, got, want)
	}
}
