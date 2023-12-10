package calculate

import "testing"

func TestSurfaceArea(t *testing.T) {
	cases := []struct {
		in []int; want int
	}{
		{ []int{6, 12, 8}, 52 },
		{ []int{1, 10, 10}, 42 },
	}
	for _, c := range cases {
		got := SurfaceArea(c.in)
		if got != c.want {
			t.Errorf("SurfaceArea(%v) == %v, want %v", c.in, got, c.want)
		}
	}
}

func TestSurfaceAreaWithSlack(t *testing.T) {
	cases := []struct {
		in string; want int
	}{
		{"2x3x4", 58},
		{"1x1x10", 43},
	}
	for _, c := range cases {
		got := SurfaceAreaWithSlack(c.in)
		if got != c.want {
			t.Errorf("SurfaceAreaWithSlack(%v) == %v, want %v", c.in, got, c.want)
		}
	}
}
