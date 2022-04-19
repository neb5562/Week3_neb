#!/usr/bin/env ruby
$LOAD_PATH << '../lib'

require 'player'

class TicTacToe
  attr_reader :finished, :winner, :in_queue
  PLAYER_X_INDEX    = 1
  PLAYER_O_INDEX    = 0
  STRING_PALYER     = 'player'.freeze
  COLOR_RED_START   = "\e[31m"
  COLOR_GREEN_START = "\e[32m"
  COLOR_END         = "\e[0m"
  ALPHABET = ('a'..'z').to_a
  STARTING_POINT = 0

  def initialize(player1, player2)
    @players    = []
    @players[1] = Player.new(player1, STARTING_POINT)
    @players[0] = Player.new(player2, STARTING_POINT)
    @board      = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
    @@turn      = 0
    @finished   = false
    @winner     = nil
    @in_queue   = @players[PLAYER_X_INDEX]
    put_board
  end

  def call(turn)
    fill_board(turn)
    put_board
    @@turn += 1
  end

  private

  def fill_board(turn)
    index_of(turn)
    check_winner
  end

  def put_board
    index = 0
    puts '    1    2    3'
    @board.each do |item|
      print "#{ALPHABET[index]} "
      item.each do |symb|
        print '|   |' if symb.nil?
        print "| #{COLOR_RED_START}X#{COLOR_END} |" if symb == PLAYER_X_INDEX
        print "| #{COLOR_GREEN_START}O#{COLOR_END} |" if symb == PLAYER_O_INDEX
      end
      index += 1
      puts
    end
  end

  def index_of(turn)
    array_1 = ALPHABET.index(turn[0]).to_i
    array_2 = turn[1].to_i - 1
    unless @board[array_1][array_2].nil?
      @@turn -= 1
      return false
    end
    if @@turn.even?
      @board[array_1][array_2] = PLAYER_X_INDEX
      @in_queue = @players[PLAYER_O_INDEX]
    else
      @board[array_1][array_2] = PLAYER_O_INDEX
      @in_queue = @players[PLAYER_X_INDEX]
    end
  end

  def check_winner
    left_right = []
    right_left = []
    i = 0
    t = @board.size - 1

    @board.each do |array|
      next unless array.include?(nil) == false && array.uniq.size == 1

      finish(array[0], @players[array[0]])
      break
    end

    second_board = @board.dup.transpose
    second_board.each do |array|
      next unless array.include?(nil) == false && array.uniq.size == 1

      finish(array[0], @players[array[0]])
      break
    end

    @board.size.times do
      left_right << @board[i][i]
      right_left << second_board.reverse[t][t]
      i += 1
      t -= 1
    end

    if left_right.include?(nil) == false && left_right.uniq.size == 1
      finish(left_right[0], @players[left_right[0]])
    end

    if right_left.include?(nil) == false && right_left.uniq.size == 1
      finish(right_left[0], @players[right_left[0]])
    end
  end

  def finish(finished, winner)
    @finished, @winner = finished, winner
  end
end
