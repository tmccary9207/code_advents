#!/usr/bin/ruby
# frozen_string_literal: true

require './logic'

look_and_say_number = [[1, 1], [1, 3], [2, 2], [2, 1], [1, 3]] #"1113222113"

# 40.times do |_|
#     look_and_say_number = look_and_say(look_and_say_number)
# end

40.times do |_|
    look_and_say_number = look_and_say_2(look_and_say_number)
end

puts "After 40 applications of LookAndSay the length is: #{look_and_say_number.length * 2}"

# 10.times do |_|
#     look_and_say_number = look_and_say(look_and_say_number)
# end

10.times do |_|
    look_and_say_number = look_and_say_2(look_and_say_number)
end

puts "After 50 applications of LookAndSay the length is: #{look_and_say_number.length * 2}"
