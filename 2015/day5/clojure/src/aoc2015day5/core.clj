(ns aoc2015day5.core
  (:require [clojure.string :as str])
  (:gen-class))

(defn has-three-or-more-vowels?
  "Checks if there are three or more vowels in a string."
  [datum]
  (some? (re-matches #".*([aeiou]).*([aeiou]).*([aeiou]).*" datum)))

(defn has-same-letter-pair?
  "Checks if there is a pair of letters repeated in a string."
  [datum]
  (some? (re-find #"(.)\1{1,}" datum)))

(defn has-no-naughty-strings?
  "Checks if there is any naughty strings in the string."
  [datum]
  (nil? (re-find #"(ab)|(cd)|(pq)|(xy)" datum)))

(defn is-string-nice?
  "Checks if string is nice."
  [datum]
  (and (has-three-or-more-vowels? datum)
       (has-same-letter-pair? datum)
       (has-no-naughty-strings? datum)))

(defn -main
  "I don't do a whole lot ... yet."
  [& args]
  (println
   (->> (str/split (slurp "../myinput.txt") #"\n")
       (filter is-string-nice?)
       count)
   " nice strings."))
