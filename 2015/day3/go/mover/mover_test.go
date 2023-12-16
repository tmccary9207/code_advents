package mover

import (
	"reflect"
	"testing"
)

func TestNewLocation(t *testing.T) {
	cases := []struct {
		in struct {
			location  []int
			direction rune
		}
		want []int
	}{
		{struct {
			location  []int
			direction rune
		}{[]int{0, 0}, '^'}, []int{0, 1}},
		{struct {
			location  []int
			direction rune
		}{[]int{0, 0}, 'v'}, []int{0, -1}},
		{struct {
			location  []int
			direction rune
		}{[]int{0, 0}, '>'}, []int{1, 0}},
		{struct {
			location  []int
			direction rune
		}{[]int{0, 0}, '<'}, []int{-1, 0}},
	}

	for _, c := range cases {
		got := NewLocation(c.in.location, c.in.direction)
		if reflect.DeepEqual(got, c.want) == false {
			t.Errorf("NewLocation(%v) == %v, want %v", c.in, got, c.want)
		}
	}
}

func TestTakeDirections(t *testing.T) {
	cases := []struct {
		in   string
		want int
	}{
		{">", 2},
		{"^>v<", 4},
		{"^v^v^v^v^v", 2},
	}

	for _, c := range cases {
		got := TakeDirections(c.in)
		if got != c.want {
			t.Errorf("TakeDirections(%v) == %d, want %d", c.in, got, c.want)
		}
	}
}
