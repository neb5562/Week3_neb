#!/usr/bin/env ruby
$LOAD_PATH << './lib'


require 'bubblesort'
array = []

puts "please numbers: (enter 'stop' to end input)"
loop do
  number = gets.chomp
  break if number == 'stop'

  array << number.to_i
end

print BubbleSort.new(array).call
