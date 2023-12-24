(ns aoc2015day4.core
  (:require [clojure.string :as string]
            [digest])
  (:gen-class))

(defn does-hash-have-five-leading-zeros
  "Checks to see if hash starts with five zeros."
  [hash]
  (string/starts-with? hash "00000"))

(defn get-lowest-number
  "Gets the lowest positive integer that when combined with the secret key produces a hash with five leading zeros."
  [secret-key]
  (first (filter
          (fn [x] (does-hash-have-five-leading-zeros (digest/md5 (str secret-key x))))
          (range))))

(defn -main
  "I don't do a whole lot ... yet."
  [& args]
  (println "The lowest number that will create an adventcoin with our key is: "
           (get-lowest-number "bgvyzdsv")))
