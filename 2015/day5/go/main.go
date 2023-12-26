package main

import (
	"day5_2015/logic"
	"fmt"
	"os"
	"strings"
)

func main() {
	b, err := os.ReadFile("../myinput.txt")
	if err != nil {
		fmt.Println(err)
		return
	}

	str := string(b)
  nice_string_count := 0
  for _, datum := range strings.Split(str, "\n") {
    if logic.IsStringNice(datum) {
      nice_string_count++
    }
  }

	fmt.Printf("%d nice strings.", nice_string_count)
}
