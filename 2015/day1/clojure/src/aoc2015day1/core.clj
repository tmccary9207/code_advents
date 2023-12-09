(ns aoc2015day1.core
  (:gen-class))

(defn reducer
  "Calculates what floor Santa is on."
  [input]
  (reduce
   (fn [tally x]
     (case x
       \( (+ tally 1)
       \) (- tally 1)
       tally))
   0
   input))

(defn -main
  "I don't do a whole lot ... yet."
  [& args]
  (println
   "Santa ends up on floor: "
   (reducer (slurp "../myinput.txt"))))
