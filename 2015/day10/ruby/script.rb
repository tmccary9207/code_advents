#!/usr/bin/ruby
# frozen_string_literal: true

require './logic'

look_and_say_number = "1113222113"

40.times do |_|
    look_and_say_number = look_and_say(look_and_say_number)
end

puts "After 40 applications of LookAndSay the length is: #{look_and_say_number.length}"

10.times do |_|
    look_and_say_number = look_and_say(look_and_say_number)
end

puts "After 50 applications of LookAndSay the length is: #{look_and_say_number.length}"
