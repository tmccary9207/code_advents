package logic

import "regexp"

// Checks if there are three or more vowels in a string.
func HasThreeOrMoreVowels(datum []byte) bool {
  re := regexp.MustCompile(`([aeiou])`)
  return len(re.FindAll(datum, -1)) > 2
}

// Checks if there is a pair of letters repeated in a string.
func HasSameLetterPair(datum string) bool {
  last := rune(datum[0])
  has_pair := false

  for _, char := range datum[1:] {
    if last == char {
      has_pair = true
      break
    }
    last = char
  }

  return has_pair
}

// Checks if there is any naughty strings in the string.
func HasNoNaughtyStrings(datum []byte) bool {
  re := regexp.MustCompile(`(ab)|(cd)|(pq)|(xy)`)
  return len(re.FindAll(datum, -1)) < 1
}

// Checks if string is nice.
func IsStringNice(datum string) bool {
  datum_bytes := []byte(datum)
  return HasThreeOrMoreVowels(datum_bytes) &&
    HasNoNaughtyStrings(datum_bytes) &&
    HasSameLetterPair(datum)
}
