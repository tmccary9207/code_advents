(ns aoc2015day6.core
  (:require [clojure.string :as string])
  (:gen-class))

(def instruction-regex
  #"(?<action>.*)\s(?<fromStart>\d+)\,(?<fromEnd>\d+).*\s(?<toStart>\d+)\,(?<toEnd>\d+)")

(defn translate-instructions
  "Translates instructions into a clojure map (if bad input is given then nil is returned)."
  [input]
  (let [matcher (re-matcher instruction-regex input)]
    (if (.matches matcher)
      {:action (.group matcher "action")
       :from-start (Integer/parseInt (.group matcher "fromStart"))
       :from-end (Integer/parseInt (.group matcher "fromEnd"))
       :to-start (Integer/parseInt (.group matcher "toStart"))
       :to-end (Integer/parseInt (.group matcher "toEnd"))}
      nil)))

(defn create-light-array
  "Creates a new light array."
  []
  (vec (repeat 1000 (vec (repeat 1000 0)))))

(defn light-array-action
  "Action handler for run-instructions."
  [action y-acc x y]
  (cond
    (= action "turn on") (assoc-in y-acc [x y] 1)
    (= action "turn off") (assoc-in y-acc [x y] 0)
    :else (assoc-in y-acc [x y] (if (= 1 (get-in y-acc [x y]))
                                  0
                                  1))))

(defn light-array-action-2
  "Action handler for run-instructions-2."
  [action y-acc x y]
  (let [state (get-in y-acc [x y])]
    (cond
      (= action "turn on") (assoc-in y-acc [x y] (+ state 1))
      (= action "turn off") (assoc-in y-acc [x y] (if (< (- state 1) 0)
                                                    0
                                                    (- state 1)))
      :else (assoc-in y-acc [x y] (+ state 2)))))

(defn update-light-array
  "Update the light array."
  [instruction light-array handler]
  (let [x-range (range (get instruction :from-start) (+ 1 (get instruction :to-start)))
        y-range (range (get instruction :from-end) (+ 1 (get instruction :to-end)))
        action (get instruction :action)]
    (reduce
     (fn [x-acc, x]
       (reduce
        (fn [y-acc, y]
          (handler action y-acc x y))
        x-acc
        y-range))
     light-array
     x-range)))

(defn count-light-array
  "Counts the lights in the array."
  [light-array]
  (reduce
   (fn [row-acc row] (+ row-acc (reduce + 0 row)))
   0
   light-array))

(defn run-instructions-loop
  "The main loop for the run-instructions function."
  [instructions light-array handler]
  (let [instruction (first instructions)]
    (cond
      ; No more instructions return the count of lights that are on.
      (= 0 (count instructions)) (count-light-array light-array)
      ; Bad instructions, go to next iter.
      (nil? instruction) (recur (rest instructions) light-array handler)
      ; Let's work on the light array.
      :else (recur (rest instructions) (update-light-array instruction light-array handler) handler))))

(defn run-instructions
  "Runs all the instructions then returns the number of lights left on."
  [input]
  (let [instructions (->> (string/split input #"\n")
                          (map translate-instructions))
        light-array (create-light-array)]
    (run-instructions-loop instructions light-array light-array-action)))

(defn run-instructions-2
  "Runs all the instructions then returns the brightness of the light array."
  [input]
  (let [instructions (->> (string/split input #"\n")
                          (map translate-instructions))
        light-array (create-light-array)]
    (run-instructions-loop instructions light-array light-array-action-2)))

(defn -main
  "I don't do a whole lot ... yet."
  [& args]
  (let [input (slurp "../myinput.txt")
        lights-on (run-instructions input)
        brightness (run-instructions-2 input)]
    (println lights-on
             " lights are on.")
    (println brightness
             " is the total brightness.")))
