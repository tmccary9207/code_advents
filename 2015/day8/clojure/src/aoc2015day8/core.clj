(ns aoc2015day8.core
  (:require [clojure.string :as string])
  (:gen-class))

(defn count-memory-chars
  "Counts the difference between the character count of
  the string literal and the memory character count."
  [input]
  (let [no-quotes (subs input 1 (dec (count input)))
        two-letter-match-count (count (re-seq #"(\\\")|(\\\\)" input))
        four-letter-match-count (count (re-seq #"(\\x[0-9|a-f|A-F]{2})" input))]
    (- (count input)
       (- (count no-quotes)
          two-letter-match-count
          (* 3 four-letter-match-count)))))

(defn count-reencode-string-chars
  "Counts the difference between the reencoded character count and
  the original string literal count."
  [input]
  (let [escaped-slash-count (count (re-seq #"(\\)" input))
        escaped-quotes-count (- (count (re-seq #"(\")" input)) 2)]
    (+ escaped-quotes-count escaped-slash-count 4)))

(defn -main
  "Main function for Day 8 of 2015 AoC."
  [& args]
  (let [lines (string/split (string/trim (slurp "../myinput.txt")) #"\n")
        [memory-chars reencode-chars] (reduce (fn [[acc-mc acc-rc] x]
                                                (list (+ acc-mc (count-memory-chars x))
                                                      (+ acc-rc (count-reencode-string-chars x))))
                                              (list 0 0)
                                              lines)]
    (println "The number of characters of code for string literals minus the number of characters in memory for the values of the strings is" memory-chars ".")
    (println "The total number of characters to represent the newly encoded strings minus the number of characters of code in each original string literal is" reencode-chars ".")))
