(ns aoc2015day5.core-test
  (:require [clojure.test :refer :all]
            [aoc2015day5.core :refer :all]))

(deftest has-three-or-more-vowels?-test
  (testing "Checks if there are three or more vowels in a string."
    (is (= true (has-three-or-more-vowels? "aei")))
    (is (= true (has-three-or-more-vowels? "xazegov")))
    (is (= true (has-three-or-more-vowels? "aeiouaeiouaeiou")))
    (is (= true (has-three-or-more-vowels? "ugknbfddgicrmopn")))
    (is (= true (has-three-or-more-vowels? "aaa")))
    (is (= true (has-three-or-more-vowels? "jchzalrnumimnmhp")))
    (is (= true (has-three-or-more-vowels? "haegwjzuvuyypxyu")))
    (is (= false (has-three-or-more-vowels? "dvszwmarrgswjxmb")))))

(deftest has-same-letter-pair?-test
  (testing "Checks if there is a pair of letters repeated in a string."
    (is (= true (has-same-letter-pair? "xx")))
    (is (= true (has-same-letter-pair? "abcdde")))
    (is (= true (has-same-letter-pair? "aabbccdd")))
    (is (= true (has-same-letter-pair? "ugknbfddgicrmopn")))
    (is (= true (has-same-letter-pair? "aaa")))
    (is (= false (has-same-letter-pair? "jchzalrnumimnmhp")))
    (is (= true (has-same-letter-pair? "haegwjzuvuyypxyu")))
    (is (= true (has-same-letter-pair? "dvszwmarrgswjxmb")))))

(deftest has-no-naughty-strings?-test
  (testing "Checks if there is any naughty strings in the string."
    (is (= true (has-no-naughty-strings? "xx")))
    (is (= false (has-no-naughty-strings? "abcdde")))
    (is (= false (has-no-naughty-strings? "aabbccdd")))
    (is (= true (has-no-naughty-strings? "ugknbfddgicrmopn")))
    (is (= true (has-no-naughty-strings? "aaa")))
    (is (= true (has-no-naughty-strings? "jchzalrnumimnmhp")))
    (is (= false (has-no-naughty-strings? "haegwjzuvuyypxyu")))
    (is (= true (has-no-naughty-strings? "dvszwmarrgswjxmb")))))

(deftest is-string-nice?-test
  (testing "Checks if string is nice."
    (is (= false (is-string-nice? "xx")))
    (is (= false (is-string-nice? "abcdde")))
    (is (= false (is-string-nice? "aabbccdd")))
    (is (= true (is-string-nice? "ugknbfddgicrmopn")))
    (is (= true (is-string-nice? "aaa")))
    (is (= false (is-string-nice? "jchzalrnumimnmhp")))
    (is (= false (is-string-nice? "haegwjzuvuyypxyu")))
    (is (= false  (is-string-nice? "dvszwmarrgswjxmb")))))
