#!/usr/bin/ruby
# frozen_string_literal: true

require './logic'

text = File.read('../myinput.txt')

memory_chars = 0
encode_chars = 0

text.split("\n").each do |line|
  memory_chars += count_memory_chars line
  encode_chars += count_reencode_string_chars line
end

puts 'The number of characters of code for string literals minus the number '\
       "of characters in memory for the values of the strings is #{memory_chars}."
puts 'The total number of characters to represent the newly encoded strings minus '\
     "the number of characters of code in each original string literal is #{encode_chars}."
