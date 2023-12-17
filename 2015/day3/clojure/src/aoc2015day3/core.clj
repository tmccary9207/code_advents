(ns aoc2015day3.core
  (:gen-class))

(defn new-location
  "Gets the new location for Santa."
  [current-location direction]
  (case direction
    \^ (list (nth current-location 0) (+ (nth current-location 1) 1))
    \v (list (nth current-location 0) (- (nth current-location 1) 1))
    \> (list (+ (nth current-location 0) 1) (nth current-location 1))
    \< (list (- (nth current-location 0) 1) (nth current-location 1))
    current-location))

(defn take-directions
  "Take in directions from an elf and returns the unique number of houses visited."
  [directions]
  (-> (reduce
       (fn [[visited-locations current-location] direction]
         (let [visited-location (new-location current-location direction)]
           (list (conj visited-locations visited-location) visited-location)))
       (list (list (list 0 0)) (list 0 0))
       directions)
      first
      set
      count))

(defn -main
  "I don't do a whole lot ... yet."
  [& args]
  (println "At least this many houses received a single present: "
           (-> (slurp "../myinput.txt")
               take-directions)))
