(ns aoc2015day2.core
  (:gen-class))

(require '[clojure.string :as str])

(defn surface-area
  "Calculates the surface area for a present."
  [sides]
  (->> sides
      (map (fn [x] (* x 2)))
      (reduce + 0)))

(defn surface-area-with-slack
  "Calculates the surface area for a present with slack."
  [present]
  (let [[length width height] (map parse-long (str/split present #"x"))
        sides (list (* length width) (* width height) (* height length))]
    (+ (surface-area sides) (apply min sides))))

(defn -main
  "I don't do a whole lot ... yet."
  [& args]
  (println "Total square feet of wrapping paper needed: "
           (->> (str/split (slurp "../myinput.txt") #"\n")
               (map surface-area-with-slack)
               (reduce + 0))))
