package logic

import "testing"

func TestHasThreeOrMoreVowels(t *testing.T) {
	cases := []struct {
		in []byte
		want bool
	}{
    { []byte(`aei`), true },
    { []byte(`xazegov`), true },
    { []byte(`aeiouaeiouaeiou`), true },
    { []byte(`ugknbfddgicrmopn`), true },
    { []byte(`aaa`), true },
    { []byte(`jchzalrnumimnmhp`), true },
    { []byte(`haegwjzuvuyypxyu`), true },
    { []byte(`dvszwmarrgswjxmb`), false },
	}

	for _, c := range cases {
		got := HasThreeOrMoreVowels(c.in)
		if got != c.want {
			t.Errorf("HasThreeOrMoreVowels(%v) == %v, want %v", c.in, got, c.want)
		}
	}
}

func TestHasSameLetterPair(t *testing.T) {
	cases := []struct {
		in string
		want bool
	}{
    { "xx", true },
    { "abcdde", true },
    { "aabbccdd", true },
    { "ugknbfddgicrmopn", true },
    { "aaa", true },
    { "jchzalrnumimnmhp", false },
    { "haegwjzuvuyypxyu", true },
    { "dvszwmarrgswjxmb", true },
	}

	for _, c := range cases {
		got := HasSameLetterPair(c.in)
		if got != c.want {
			t.Errorf("HasSameLetterPair(%v) == %v, want %v", c.in, got, c.want)
		}
	}
}

func TestHasNoNaughtyStrings(t *testing.T) {
	cases := []struct {
		in []byte
		want bool
	}{
    { []byte(`xx`), true },
    { []byte(`abcdde`), false },
    { []byte(`aabbccdd`), false },
    { []byte(`ugknbfddgicrmopn`), true },
    { []byte(`aaa`), true },
    { []byte(`jchzalrnumimnmhp`), true },
    { []byte(`haegwjzuvuyypxyu`), false },
    { []byte(`dvszwmarrgswjxmb`), true },
	}

	for _, c := range cases {
		got := HasNoNaughtyStrings(c.in)
		if got != c.want {
			t.Errorf("HasNoNaughtyStrings(%v) == %v, want %v", c.in, got, c.want)
		}
	}
}

func TestIsStringNice(t *testing.T) {
	cases := []struct {
		in string
		want bool
	}{
    { "xx", false },
    { "abcdde", false },
    { "aabbccdd", false },
    { "ugknbfddgicrmopn", true },
    { "aaa", true },
    { "jchzalrnumimnmhp", false },
    { "haegwjzuvuyypxyu", false },
    { "dvszwmarrgswjxmb", false },
	}

	for _, c := range cases {
		got := IsStringNice(c.in)
		if got != c.want {
			t.Errorf("IsStringNice(%v) == %v, want %v", c.in, got, c.want)
		}
	}
}
