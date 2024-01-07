#!/usr/bin/ruby
# frozen_string_literal: true

require './logic'

text = File.read('../myinput.txt')

wire_a_value = run_instructions(text)

puts "Wire A's value is #{wire_a_value}."

wire_a_new_value = run_instructions(text, 'a', { 'wire' => 'b', 'value' => wire_a_value })

puts "Wire A's value when B is overridden with #{wire_a_value} is #{wire_a_new_value}."
