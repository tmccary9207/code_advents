package calculate

import (
	"testing"
)

func TestWhichFloor(t *testing.T) {
	cases := []struct {
		in string; want int
	}{
		{"(())", 0},
		{"()()", 0},
		{"(((", 3},
		{"(()(()(", 3},
		{"))(((((", 3},
		{"())", -1},
		{"))(", -1},
		{")))", -3},
		{")())())", -3},
	}
	for _, c := range cases {
		got := WhichFloor(c.in)
		if got != c.want {
			t.Errorf("whichFloor(%q) == %d, want %d", c.in, got, c.want)
		}
	}
}
