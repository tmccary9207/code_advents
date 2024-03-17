package logic

import (
	"testing"
)

func TestCountMemoryChars(t *testing.T) {
	cases := []struct {
		in   string
		want int
	}{
		{`""`, 2},
		{`"abc"`, 2},
		{`"aaa\"aaa"`, 3},
		{`"\x27"`, 5},
	}

	for _, c := range cases {
		got := CountMemoryChars(c.in)
		if got != c.want {
			t.Errorf("CountMemoryChars(%v) == %v, want %v", c.in, got, c.want)
		}
	}
}

func TestCountReencodeStringChars(t *testing.T) {
	cases := []struct {
		in   string
		want int
	}{
		{`""`, 4},
		{`"abc"`, 4},
		{`"aaa\"aaa"`, 6},
		{`"\x27"`, 5},
	}

	for _, c := range cases {
		got := CountReencodeStringChars(c.in)
		if got != c.want {
			t.Errorf("CountReencodeStringChars(%v) == %v, want %v", c.in, got, c.want)
		}
	}
}
