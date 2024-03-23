(ns aoc2015day8.core-test
  (:require [clojure.test :refer :all]
            [aoc2015day8.core :refer :all]))

(deftest count-memory-chars-test
  (testing "Count memory chars"
    (is (= 2 (count-memory-chars "\"\"")))
    (is (= 2 (count-memory-chars "\"abc\"")))
    (is (= 3 (count-memory-chars "\"aaa\\\"aaa\"")))
    (is (= 5 (count-memory-chars "\"\\x27\"")))
    (is (= 9 (count-memory-chars "\"xrgcripdu\\x4c\\xc4gszjhrvumvz\\\"mngbirb\"")))
    (is (= 4 (count-memory-chars "\"\\\\\\\\zkisyjpbzandqikqjqvee\"")))))

(deftest count-reencode-string-chars-test
  (testing "Count reencode string chars"
    (is (= 4 (count-reencode-string-chars "\"\"")))
    (is (= 4 (count-reencode-string-chars "\"abc\"")))
    (is (= 6 (count-reencode-string-chars "\"aaa\\\"aaa\"")))
    (is (= 5 (count-reencode-string-chars "\"\\x27\"")))))
