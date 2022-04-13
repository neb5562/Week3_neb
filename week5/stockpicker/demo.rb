#!/usr/bin/env ruby
$LOAD_PATH << './lib'

require 'stockpicker'
prices = []

puts "please prices: (enter 'stop' to end input)"
loop do
  price = gets.chomp
  break if price == 'stop'

  prices << price
end

print StockPicker.new(prices).call

