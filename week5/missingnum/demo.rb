#!/usr/bin/env ruby
$LOAD_PATH << './lib'

require "arrmissnum"

temp_array = []
9.times do
  puts "please enter number for array:"
  temp_array << gets.chomp.to_i
end
number = ArrMissNum.new(temp_array).call

print "missing number: #{number} \n" if number
