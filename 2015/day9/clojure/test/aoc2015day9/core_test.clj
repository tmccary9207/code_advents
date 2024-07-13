(ns aoc2015day9.core-test
  (:require [clojure.test :refer :all]
            [aoc2015day9.core :refer :all]))

(deftest line-to-parts-test
  (testing "line-to-parts simple input example."
    (is (= (list "x" "y" 1)
           (line-to-parts "x to y = 1")))))

(deftest get-route-map-test
  (testing "get-route-map over a simple map exmaple."
    (is (= {"Belfast" {"Dublin" 141 "London" 518}
            "Dublin" {"Belfast" 141 "London" 464}
            "London" {"Belfast" 518 "Dublin" 464}}
           (get-route-map (list (list "London" "Dublin" 464)
                                (list "London" "Belfast" 518)
                                (list "Dublin" "Belfast" 141)))))))

(deftest calculate-distance-for-route-test
  (testing "calculate-distance-for-route the shortest from Belfast should be 605."
    (is (= 605
           (calculate-distance-for-route {"Belfast" {"Dublin" 141 "London" 518}
                                          "Dublin" {"Belfast" 141 "London" 464}
                                          "London" {"Belfast" 518 "Dublin" 464}}
                                         999999
                                         "Belfast"
                                         <)))))

(deftest get-xest-route-test
  (testing "Gets the shortest route distance."
    (is (= 605
           (get-xest-route {"Belfast" {"Dublin" 141 "London" 518}
                            "Dublin" {"Belfast" 141 "London" 464}
                            "London" {"Belfast" 518 "Dublin" 464}}
                           999999
                           <))))
  (testing "Gets the longest route distance."
    (is (= 982
           (get-xest-route {"Belfast" {"Dublin" 141 "London" 518}
                            "Dublin" {"Belfast" 141 "London" 464}
                            "London" {"Belfast" 518 "Dublin" 464}}
                           0
                           >)))))
