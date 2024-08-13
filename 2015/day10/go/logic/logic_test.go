package logic

import (
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
