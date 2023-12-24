(ns aoc2015day4.core-test
  (:require [clojure.test :refer :all]
            [aoc2015day4.core :refer :all]))

(deftest does-hash-have-five-leading-zeros-test
  (testing "does-hash-have-five-leading-zeros"
    (is (= true (does-hash-have-five-leading-zeros "0000012345")))
    (is (= false (does-hash-have-five-leading-zeros "0000112345")))))

(deftest get-lowest-number-test
  (testing "get-lowest-number"
    (is (= 609043 (get-lowest-number "abcdef")))
    (is (= 1048970 (get-lowest-number "pqrstuv")))))
