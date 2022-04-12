#!/usr/bin/env ruby
$LOAD_PATH << './lib'

require "repdigit"



puts "please enter number to check if it's repdigit"
dig = RepDigit.new(gets.chomp).call
puts dig
