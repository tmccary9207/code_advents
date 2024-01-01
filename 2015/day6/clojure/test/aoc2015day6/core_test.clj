(ns aoc2015day6.core-test
  (:require [clojure.test :refer :all]
            [aoc2015day6.core :refer :all]))

(deftest translate-instructions-test
  (testing "translate-instructions"
    (is (= {:action "turn on"
            :from-start 0
            :from-end 0
            :to-start 999
            :to-end 999}
           (translate-instructions "turn on 0,0 through 999,999")))
    (is (= {:action "toggle"
            :from-start 0
            :from-end 0
            :to-start 999
            :to-end 0}
           (translate-instructions "toggle 0,0 through 999,0")))
    (is (= {:action "turn off"
            :from-start 499
            :from-end 499
            :to-start 500
            :to-end 500}
           (translate-instructions "turn off 499,499 through 500,500")))))

(deftest run-instructions-test
  (testing "run-instructions"
    (is (= 1000000
           (run-instructions "turn on 0,0 through 999,999\n")))
    (is (= 1000
           (run-instructions "toggle 0,0 through 999,0\n")))
    (is (= 999996
           (run-instructions "turn on 0,0 through 999,999\nturn off 499,499 through 500,500\n")))))

(deftest run-instructions-2-test
  (testing "run-instructions-2"
    (is (= 1000000
           (run-instructions-2 "turn on 0,0 through 999,999\n")))
    (is (= 2000
           (run-instructions-2 "toggle 0,0 through 999,0\n")))
    (is (= 999996
           (run-instructions-2 "turn on 0,0 through 999,999\nturn off 499,499 through 500,500\n")))
    (is (= 1
           (run-instructions-2 "turn on 0,0 through 0,0\n")))
    (is (= 2000000
           (run-instructions-2 "toggle 0,0 through 999,999\n")))))
