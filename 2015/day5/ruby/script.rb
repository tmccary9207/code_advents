#!/usr/bin/ruby

require './logic'

text = File.read('../myinput.txt')
nice_string_count = text.split("\n").select { |x| is_string_nice(x) }.size

puts "#{nice_string_count} nice strings."
