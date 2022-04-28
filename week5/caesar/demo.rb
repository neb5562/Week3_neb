#!/usr/bin/env ruby
$LOAD_PATH << './lib'

require "caesar"



puts "please enter string to cypher:"
str = gets.chomp
puts "please enter shift number:"
shift = gets.chomp

puts Caesar.new(str, shift).call

