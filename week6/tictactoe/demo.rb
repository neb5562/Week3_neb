#!/usr/bin/env ruby
$LOAD_PATH << './lib'

require 'tictactoe'

puts 'please enter player one name: '
player1 = gets.chomp
puts 'please enter player two name: '
player2 = gets.chomp

game = TicTacToe.new(player1, player2)

until game.finished
  puts "#{game.in_queue.name}, please enter index to fill: (example 'a1')"
  game.call(gets.chomp)
  if game.finished != false
    puts "Player #{game.winner.name} won!"
    break
  end
end
