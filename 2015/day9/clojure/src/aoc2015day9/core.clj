(ns aoc2015day9.core
  (:require [clojure.string :as string])
  (:gen-class))

(defn line-to-parts
  "Takes a line of input and returns a list of origin, destination and distance."
  [input]
  (let [[origin _ destination _ distance-string] (string/split input #" ")
        distance (Integer/parseInt distance-string)]
    (list origin destination distance)))

(defn get-route-map
  "Take in a list of part lists and returns a map of routes."
  [parts]
  (reduce
   (fn [routes [origin destination distance]]
     (let [origin-map (or (get routes origin) {})
           destination-map (or (get routes destination) {})]
       (assoc routes
              origin (assoc origin-map destination distance)
              destination (assoc destination-map origin distance))))
   {}
   parts))

(defn calculate-distance-for-route
  "Calculates the shortest or longest distance for a route using a comparator."
  [routes start-value start-location comparator]
  (loop [distance 0
         current-loc start-location
         not-visited (set (filter (fn [x] (not (= x start-location)))
                                  (keys routes)))]
    (let [current-loc-routes (get routes current-loc)
          possible-destinations (set (filter
                                      (fn [x] (contains? not-visited x))
                                      (keys current-loc-routes)))]
      (cond (= (count not-visited) 0) distance
            (= (count possible-destinations) 0) nil
            :else (let [[next-distance next-current] (reduce
                                                      (fn [chosen destination]
                                                        (let [destination-distance (get current-loc-routes destination)
                                                              [chosen-distance _] chosen]
                                                          (if (comparator destination-distance chosen-distance)
                                                            (list destination-distance destination)
                                                            chosen)))
                                                      (list start-value "")
                                                      possible-destinations)]
                    (recur
                     (+ distance next-distance)
                     next-current
                     (set (filter (fn [x] (not (= x next-current)))
                                  not-visited))))))))

(defn get-xest-route
  "Gets the shortest or longest route based on the comparator."
  [routes start-value comparator]
  (->>
   (keys routes)
   (map (fn [start-location]
          (calculate-distance-for-route routes start-value start-location comparator)))
   (remove nil?)
   (reduce (fn [goal x]
             (if (comparator x goal)
               x
               goal)))))

(defn -main
  "Main function for Day 9 of 2015 AoC."
  [& args]
  (let [lines (string/split (string/trim (slurp "../myinput.txt")) #"\n")
        routes (get-route-map (map line-to-parts lines))
        shortest (get-xest-route routes 999999 <)
        longest (get-xest-route routes 0 >)]
    (println "Shortest possible distance is: " shortest)
    (println "Longest possible distance is: " longest)))
