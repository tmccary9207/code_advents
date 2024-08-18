(ns aoc2015day10.core-test
  (:require [clojure.test :refer :all]
            [aoc2015day10.core :refer :all]))

(deftest look-and-say-test
  (testing "Look and Say sequence function."
    (is (= (list (list 2 1))
           (look-and-say (list (list 1 1)) 1)))
    (is (= (list (list 1 2) (list 1 1))
           (look-and-say (list (list 1 1)) 2)))
    (is (= (list (list 1 1) (list 1 2) (list 2 1))
           (look-and-say (list (list 1 1)) 3))) 
    (is (= (list (list 3 1) (list 2 2) (list 1 1))
           (look-and-say (list (list 1 1)) 4)))))
