(ns aoc2015day7.core-test
  (:require [clojure.test :refer :all]
            [aoc2015day7.core :refer :all]))

(deftest line-to-label-and-wire-test
  (testing "Line to label and wire instruction map pair."
    (is (= (line-to-label-and-wire "ab AND ac -> x")
           (list "x" {:action "AND", :named-args (list "ab" "ac"), :numerical-args ()})))
    (is (= (line-to-label-and-wire "1 AND 2 -> x")
           (list "x" {:action "AND", :named-args (), :numerical-args (list 1 2)})))))

(deftest get-value-for-wire-test
  (testing "Value for wire function."
    (let [calculations {"x" 123 "y" 456}]
      (is (= (get-value-for-wire
              {:action "AND", :named-args (list "x" "y"), :numerical-args ()}
              calculations)
             72))
      (is (= (get-value-for-wire
              {:action "OR", :named-args (list "x" "y"), :numerical-args ()}
              calculations)
             507))
      (is (= (get-value-for-wire
              {:action "LSHIFT", :named-args (list "x"), :numerical-args (list 2)}
              calculations)
             492))
      (is (= (get-value-for-wire
              {:action "RSHIFT", :named-args (list "y"), :numerical-args (list 2)}
              calculations)
             114))
      (is (= (get-value-for-wire
              {:action "NOT", :named-args (list "x"), :numerical-args ()}
              calculations)
             65412))
      (is (= (get-value-for-wire
              {:action nil, :named-args (list "x"), :numerical-args ()}
              calculations)
             123)))))

(deftest run-instructions-test
  (testing "1st stage instructions runner."
    (let [instructions (parse "123 -> x\n456 -> y\nx AND y -> d\nx OR y -> e\nx LSHIFT 2 -> f\ny RSHIFT 2 -> g\nNOT x -> h\nNOT y -> i")]
      (is (= (run-instructions instructions "d")
             72)))))
