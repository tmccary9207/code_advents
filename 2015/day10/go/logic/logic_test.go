package logic

import (
	"reflect"
	"testing"
)

func TestLookAndSay(t *testing.T) {
	cases := []struct {
		in   string
		want string
	}{
		{"1", "11"},
		{"11", "21"},
		{"21", "1211"},
		{"1211", "111221"},
		{"111221", "312211"},
	}

	for _, c := range cases {
		got := LookAndSay(c.in)
		if got != c.want {
			t.Errorf("LookAndSay(%v) == %v, want %v", c.in, got, c.want)
		}
	}
}

func TestLookAndSay2(t *testing.T) {
	cases := []struct {
		in   [][]int
		want [][]int
	}{
		{[][]int{{1, 1}}, [][]int{{2, 1}}},
		{[][]int{{2, 1}}, [][]int{{1, 2}, {1, 1}}},
		{[][]int{{1, 2}, {1, 1}}, [][]int{{1, 1}, {1, 2}, {2, 1}}},
		{[][]int{{1, 1}, {1, 2}, {2, 1}}, [][]int{{3, 1}, {2, 2}, {1, 1}}},
	}

	for _, c := range cases {
		got := LookAndSay2(c.in)
		if reflect.DeepEqual(got, c.want) == false {
			t.Errorf("LookAndSay2(%v) == %v, want %v", c.in, got, c.want)
		}
	}
}
