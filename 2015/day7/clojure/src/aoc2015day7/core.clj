(ns aoc2015day7.core
  (:require [clojure.string :as string])
  (:gen-class))

(defn line-to-label-and-wire
  "Turns a line into a label and instruction pair."
  [line]
  (let [[ops label] (string/split line #" -> ")
        action (re-find #"[A-Z]+" ops)
        named-args (or (re-seq #"[a-z]+" ops) ())
        numerical-args (map  (fn [x] (Integer/parseInt x)) (re-seq #"[0-9]+" ops))]
    (list label {:action action
                 :named-args named-args
                 :numerical-args numerical-args})))

(defn parse
  "Turns the input string into a list with a list pair of label and instruction."
  [input]
  (let [lines (-> input
                  string/trim-newline
                  (string/split #"\n"))]
    (map (fn [line] (line-to-label-and-wire line)) lines)))

(defn all-named-args-present
  "Tests to see if all named args are available."
  [instructions calculated-values]
  (every? calculated-values (:named-args instructions)))

(defn get-value-for-wire
  "Calculates the value for the instructions."
  [instructions calculations]
  (let [[left right] (concat (map (fn [x] (get calculations x)) (:named-args instructions))
                             (:numerical-args instructions))]
    (case (:action instructions)
      "AND" (bit-and left right)
      "OR" (bit-or left right)
      "NOT" (bit-and-not 16rFFFF left)
      "LSHIFT" (bit-shift-left left right)
      "RSHIFT" (bit-shift-right left right)
      left)))

(defn instructions-reducer
  "The reducer funtion for the run-instructions function."
  [[acc-instructions acc-calculations] item]
  (let [[wire-label wire-instruction] item]
    (if (all-named-args-present wire-instruction acc-calculations)
      [acc-instructions (assoc acc-calculations wire-label (get-value-for-wire wire-instruction acc-calculations))]
      [(conj acc-instructions item) acc-calculations])))

(defn run-instructions
  "Runs all the instructions and returns the target wire's value."
  [instruction-list target-wire]
  (loop [instruction-list instruction-list
         calculations {}]
    (if (get calculations target-wire)
      (get calculations target-wire)
      (let [[new-instructions new-calculations] (reduce
                                                 instructions-reducer
                                                 [() calculations]
                                                 instruction-list)]
        (recur new-instructions new-calculations)))))

(defn run-instruction-override
  "Runs all the instructions with an override then returns the target wire's value."
  [instructions target-wire override-label override-value]
  (let [override-instructions (conj (filter (fn [[label _]] (not= label override-label)) instructions)
                                    (list override-label {:action ""
                                                          :named-args ()
                                                          :numerical-args (list override-value)}))]
    (run-instructions override-instructions target-wire)))

(defn -main
  "Main function for day7 of 2015 advent of code."
  [& _args]
  (let [input-text (slurp "../myinput.txt")
        instructions (parse input-text)
        stage-1-a-value (run-instructions instructions "a")
        stage-2-a-value (run-instruction-override instructions "a" "b" stage-1-a-value)]
    (println "Wire A's value is" stage-1-a-value ".")
    (println "Wire A's value when B is overridden with" stage-1-a-value "is" stage-2-a-value ".")))
