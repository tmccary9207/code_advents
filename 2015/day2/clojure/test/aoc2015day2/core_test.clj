(ns aoc2015day2.core-test
  (:require [clojure.test :refer :all]
            [aoc2015day2.core :refer :all]))

(deftest surface-area-test
  (testing "Calculates the surface area of a present."
    (is (= 52 (surface-area '(6 12 8))))
    (is (= 42 (surface-area '(1 10 10))))))

(deftest surface-area-with-slack-test
  (testing "Calculates the surface are of a present with slack."
    (is (= 58 (surface-area-with-slack "2x3x4")))
    (is (= 43 (surface-area-with-slack "1x1x10")))))
