package logic

import "testing"

func TestTranslateInstructions(t *testing.T) {
	cases := []struct {
		in   string
		want instructions
	}{
		{"turn on 0,0 through 999,999", instructions{action: "turn on", fromStart: 0, fromEnd: 0, toStart: 999, toEnd: 999}},
		{"toggle 0,0 through 999,0", instructions{action: "toggle", fromStart: 0, fromEnd: 0, toStart: 999, toEnd: 0}},
		{"turn off 499,499 through 500,500", instructions{action: "turn off", fromStart: 499, fromEnd: 499, toStart: 500, toEnd: 500}},
	}

	for _, c := range cases {
		got, _ := TranslateInstructions(c.in)
		if got != c.want {
			t.Errorf("TranslateInstructions(%v) == %v, want %v", c.in, got, c.want)
		}
	}
}

func TestRunInstructions(t *testing.T) {
	cases := []struct {
		in   string
		want int
	}{
		{"turn on 0,0 through 999,999", 1000000},
		{"toggle 0,0 through 999,0", 1000},
		{"turn on 0,0 through 999,999\nturn off 499,499 through 500,500\n", 999996},
	}

	for _, c := range cases {
		got := RunInstructions(c.in)
		if got != c.want {
			t.Errorf("RunInstructions(%v) == %v, want %v", c.in, got, c.want)
		}
	}
}

func TestRunInstructions2(t *testing.T) {
	cases := []struct {
		in   string
		want int
	}{
		{"turn on 0,0 through 999,999", 1000000},
		{"toggle 0,0 through 999,0", 2000},
		{"turn on 0,0 through 999,999\nturn off 499,499 through 500,500\n", 999996},
		{"turn on 0,0 through 0,0\n", 1},
		{"toggle 0,0 through 999,999\n", 2000000},
	}

	for _, c := range cases {
		got := RunInstructions2(c.in)
		if got != c.want {
			t.Errorf("RunInstructions2(%v) == %v, want %v", c.in, got, c.want)
		}
	}
}
