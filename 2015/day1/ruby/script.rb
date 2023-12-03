#!/usr/bin/ruby

require './reducer'

text = File.read('../myinput.txt').delete('\r\n')

puts "Santa ends up on floor: #{reducer(text)}"
