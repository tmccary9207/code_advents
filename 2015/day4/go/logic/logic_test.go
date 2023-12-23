package logic

import "testing"

func TestDoesHashHaveFiveLeadingZeros(t *testing.T) {
	cases := []struct {
		in string
		want bool
	}{
    { "000001", true },
    { "000011", false },
	}

	for _, c := range cases {
		got := DoesHashHaveFiveLeadingZeros(c.in)
		if got != c.want {
			t.Errorf("DoesHashHaveFiveLeadingZeros(%v) == %v, want %v", c.in, got, c.want)
		}
	}
}

func TestGetLowestNumber(t *testing.T) {
	cases := []struct {
		in string
		want int
	}{
    { "abcdef", 609043 },
    { "pqrstuv", 1048970 },
	}

	for _, c := range cases {
		got := GetLowestNumber(c.in)
		if got != c.want {
			t.Errorf("GetLowestNumber(%v) == %v, want %v", c.in, got, c.want)
		}
	}
}

