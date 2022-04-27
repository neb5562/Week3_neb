#!/usr/bin/env ruby
$LOAD_PATH << './lib'

require "suminfib"

puts "please enter first number of range:"
first_number = gets.chomp
puts "please enter second number of range:"
second_number = gets.chomp

sum = SumInFib.new(first_number, second_number).call

puts "Sum of even fibonacci numbers in this range is: #{sum}"
