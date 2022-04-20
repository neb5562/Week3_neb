#!/usr/bin/env ruby
$LOAD_PATH << './lib'

require 'tictactoe'

puts 'please enter player one name: '
player1 = gets.chomp
puts 'please enter player two name: '
player2 = gets.chomp

puts TicTacToe.new(player1, player2).call
