#!/usr/bin/ruby
# frozen_string_literal: true

require './logic'

text = File.read('../myinput.txt')

routes = get_route_map(text.split("\n").map { |x| line_to_parts(x) })
shortest = get_shortest_route(routes)
longest = get_longest_route(routes)

puts "Shortest possible distance is: #{shortest}"
puts "Longest possible distance is: #{longest}"
