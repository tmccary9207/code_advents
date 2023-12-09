#!/usr/bin/ruby

require './surface_calculator'

text = File.read('../myinput.txt').strip
total_surface_area = text.split("\n").map { |x| surface_area_with_slack(x) }.sum

puts "Total square feet of wrapping paper needed: #{total_surface_area}"
