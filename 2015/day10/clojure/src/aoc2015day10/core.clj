(ns aoc2015day10.core
  (:gen-class))

(defn look-and-say
  "Performs the look and say sequence on the pairs for number of iterations."
  [pairs iterations]
  (loop [carry (first (first pairs))
         carry-count 0
         remaining pairs
         output (list)
         remaining-iters iterations]
    (cond
      (and (= 0 (count remaining)) (= 1 remaining-iters)) (reverse (conj output (list carry-count carry)))
      (= 0 (count remaining)) (let [temp (reverse (conj output (list carry-count carry)))]
                                (recur (first (first temp))
                                       0
                                       temp
                                       (list)
                                       (dec remaining-iters)))
      :else (let [pair (first remaining)
                  left (first pair)
                  right (second pair)
                  left-right-same (= left right)]
              (if (= carry left)
                (if left-right-same
                  (recur carry (+ 2 carry-count) (rest remaining) output remaining-iters)
                  (recur right 1 (rest remaining) (conj output (list (+ 1 carry-count) carry)) remaining-iters))
                (if left-right-same
                  (recur right 2 (rest remaining) (conj output (list carry-count carry)) remaining-iters)
                  (recur right 1 (rest remaining) (conj output (list carry-count carry) (list 1 left)) remaining-iters)))))))

(defn -main
  "I don't do a whole lot ... yet."
  [& _]
  (let [forty-iters (look-and-say (list (list 1 1) (list 1 3) (list 2 2) (list 2 1) (list 1 3)) 40)]
    (println "After 40 applications of LookAndSay the length is: " (* 2 (count forty-iters)))
    (println "After 50 applications of LookAndSay the length is: " (* 2 (count (look-and-say forty-iters 10))))))
