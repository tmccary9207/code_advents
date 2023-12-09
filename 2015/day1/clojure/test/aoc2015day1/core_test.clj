(ns aoc2015day1.core-test
  (:require [clojure.test :refer :all]
            [aoc2015day1.core :refer :all]))

(deftest reducer-test
  (testing "reducer that tells us what floor Santa is on."
    (is (= 0 (reducer "(())")))
    (is (= 0 (reducer "()()")))
    (is (= 3 (reducer "(((")))
    (is (= 3 (reducer "(()(()(")))
    (is (= 3 (reducer "))(((((")))
    (is (= -1 (reducer "())")))
    (is (= -1 (reducer "))(")))
    (is (= -3 (reducer ")))")))
    (is (= -3 (reducer ")())())")))))
