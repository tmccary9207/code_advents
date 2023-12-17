(ns aoc2015day3.core-test
  (:require [clojure.test :refer :all]
            [aoc2015day3.core :refer :all]))

(deftest new-location-test
  (testing "Gets the new location for Santa."
    (is (= '(0 1) (new-location '(0 0) \^)))
    (is (= '(0 -1) (new-location '(0 0) \v)))
    (is (= '(1 0) (new-location '(0 0) \>)))
    (is (= '(-1 0) (new-location '(0 0) \<)))))

(deftest take-directions-test
  (testing "Returns the unique number of houses visted."
    (is (= 2 (take-directions "^")))
    (is (= 4 (take-directions "^>v<")))
    (is (= 2 (take-directions "^v^v^v^v^v")))))
