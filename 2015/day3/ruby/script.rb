#!/usr/bin/ruby

require './mover'

text = File.read('../myinput.txt')
houses_visited = take_directions(text)

puts "At least this many houses received a single present: #{houses_visited}"
