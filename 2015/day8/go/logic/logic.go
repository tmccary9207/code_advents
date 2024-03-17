package logic

import (
	"regexp"
	"strings"
)

var memoryCharsRegex = regexp.MustCompile(`(\\")|(\\\\)`)
var fourLetterCharsRegex = regexp.MustCompile(`(\\x[0-9|a-f|A-F]{2})`)
var escapedSlashCharRegex = regexp.MustCompile(`(\\)`)
var escapedQuoteCharRegex = regexp.MustCompile(`(")`)

func CountMemoryChars(input string) int {
	noQuotes := strings.Trim(input, "\"")
	twoLetterMatchCount := len(memoryCharsRegex.FindAllIndex([]byte(noQuotes), -1))
	fourLetterMatchCount := len(fourLetterCharsRegex.FindAllIndex([]byte(noQuotes), -1))
	return len(input) -
		(len(noQuotes) - (twoLetterMatchCount + (3 * fourLetterMatchCount)))
}

func CountReencodeStringChars(input string) int {
	escapedSlashCount := len(escapedSlashCharRegex.FindAllIndex([]byte(input), -1))
	escapedQuoteCount := len(escapedQuoteCharRegex.FindAllIndex([]byte(input), -1)) - 2
	return (escapedSlashCount + escapedQuoteCount) + 4
}
