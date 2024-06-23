package logic

import (
	"fmt"
	"strings"
	"testing"
)

func TestLineToParts(t *testing.T) {
	in := "London to Dublin = 464"
	want := Parts{
		origin:      "London",
		destination: "Dublin",
		distance:    464,
	}
	got := LineToParts(in)
	if fmt.Sprint(want) != fmt.Sprint(got) {
		t.Errorf("LineToParts(%v) == %v, want %v", in, got, want)
	}
}

func TestGetRouteMap(t *testing.T) {
	exampleString :=
		"London to Dublin = 464\nLondon to Belfast = 518\nDublin to Belfast = 141"
	exampleStringSlices := strings.Split(exampleString, "\n")
	var in []Parts
	for _, input := range exampleStringSlices {
		in = append(in, LineToParts(input))
	}
	want := Routemap{
		"Belfast": {"Dublin": 141, "London": 518},
		"Dublin":  {"Belfast": 141, "London": 464},
		"London":  {"Belfast": 518, "Dublin": 464},
	}
	got := GetRouteMap(in)
	if fmt.Sprint(want) != fmt.Sprint(got) {
		t.Errorf("GetRouteMap(%v) == %v, want %v", in, got, want)
	}
}

func TestGetShortestRoute(t *testing.T) {
	cases := []struct {
		in   Routemap
		want uint64
	}{
		{Routemap{
			"Belfast": {"Dublin": 141, "London": 518},
			"Dublin":  {"Belfast": 141, "London": 464},
			"London":  {"Belfast": 518, "Dublin": 464},
		}, 605},
		{Routemap{
			"1": {"2": 7, "3": 9, "6": 14},
			"2": {"1": 7, "3": 10, "4": 15},
			"3": {"2": 10, "4": 11, "1": 9, "6": 2},
			"4": {"2": 15, "3": 11, "5": 6},
			"5": {"4": 6, "6": 9},
			"6": {"5": 9, "3": 2, "1": 14},
		}, 33},
	}

	for _, c := range cases {
		got := GetShortestRoute(c.in)
		if got != c.want {
			t.Errorf("GetShortestRoute(%v) == %v, want %v", c.in, got, c.want)
		}
	}
}

func TestGetLongestRoute(t *testing.T) {
	cases := []struct {
		in   Routemap
		want uint64
	}{
		{Routemap{
			"Belfast": {"Dublin": 141, "London": 518},
			"Dublin":  {"Belfast": 141, "London": 464},
			"London":  {"Belfast": 518, "Dublin": 464},
		}, 982},
		{Routemap{
			"1": {"2": 7, "3": 9, "6": 14},
			"2": {"1": 7, "3": 10, "4": 15},
			"3": {"2": 10, "4": 11, "1": 9, "6": 2},
			"4": {"2": 15, "3": 11, "5": 6},
			"5": {"4": 6, "6": 9},
			"6": {"5": 9, "3": 2, "1": 14},
		}, 58},
	}

	for _, c := range cases {
		got := GetLongestRoute(c.in)
		if got != c.want {
			t.Errorf("GetLongestRoute(%v) == %v, want %v", c.in, got, c.want)
		}
	}
}
