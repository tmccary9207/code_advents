package logic

import (
  "crypto/md5"
  "encoding/hex"
  "fmt"
  "math"
)

// Checks to see if the first five runes of a hash are 0.
func DoesHashHaveFiveLeadingZeros(hash string) bool {
  firstFiveRunes := hash[0:5]
  return firstFiveRunes == "00000"
}

// Returns the lowest possible positive integer that when hashed with the secret key
// yeilds a MD5 hash with five leading zeros.
func GetLowestNumber(secretKey string) int {
  lowestNumber := 0

  for {
    if !(lowestNumber < math.MaxInt) {
      // Prevent Int32 overlfow
      break
    }

    hash := md5.Sum([]byte(fmt.Sprintf("%s%d", secretKey, lowestNumber)))

    if DoesHashHaveFiveLeadingZeros(hex.EncodeToString(hash[:])) {
      break
    }

    lowestNumber++
  }

  return lowestNumber
}
