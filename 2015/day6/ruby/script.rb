#!/usr/bin/ruby

require './logic'

text = File.read('../myinput.txt')

number_of_lights_on = run_instructions(text)

puts "#{number_of_lights_on} lights are on."

brightness = run_instructions2(text)

puts "#{brightness} is the total brightness."
