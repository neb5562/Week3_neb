#!/usr/bin/env ruby
$LOAD_PATH << '../lib'

require 'player'

class TicTacToe
  PLAYER_X_INDEX      = 1
  PLAYER_O_INDEX      = 0
  TITLE_SPACE_BETWEEN = 4
  COLOR_RED_START     = "\e[31m"
  COLOR_GREEN_START   = "\e[32m"
  COLOR_END           = "\e[0m"
  ALPHABET            = %w[a b c].freeze
  STARTING_POINT      = 0
  MESSAGE_TO_USER     = "%s, please enter index to fill: (example 'a1'), to end game enter: 'end'\n".freeze
  GAME_OVER           = "\nGame Over!\n".freeze
  USER_RESULT_MESSAGE = "%s: %d points\n".freeze
  PLAY_AGAIN_MESSAGE  = "Play again? (y/n):\n".freeze
  PLAYER_WON_MESSAGE  = "Player %s won!\n".freeze
  GAME_DRAW_MESSAGE   = "It's draw!\n".freeze

  def initialize(player1, player2)
    @players                 = []
    @players[PLAYER_X_INDEX] = Player.new(player1, STARTING_POINT)
    @players[PLAYER_O_INDEX] = Player.new(player2, STARTING_POINT)
    @board                   = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
    @turn                    = 0
    @finished                = false
    @winner                  = nil
    @in_queue                = @players[PLAYER_X_INDEX]
    @moves                   = {}
  end

  def call
    run
  end

  private

  def run 
    until @finished
      put_board
      printf(MESSAGE_TO_USER, @in_queue.name)
      input = gets.chomp
      finish if input == 'end'
      fill_board(input)
      draw if board_full
      @turn += 1
    end
  end

  def fill_board(turn)
    index_of(turn)
    check_winner
  end

  def put_board
    index = 0
    print_header
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
    array_1 = ALPHABET.index(turn[0].downcase).to_i
    array_2 = turn[1].to_i - 1
    unless @board[array_1][array_2].nil?
      @turn -= 1
      return false
    end
    if @turn.even?
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

      round_won(@players[array[0]])
      break
    end

    second_board = @board.dup.transpose
    second_board.each do |array|
      next unless array.include?(nil) == false && array.uniq.size == 1

      round_won(@players[array[0]])
      break
    end

    @board.size.times do
      left_right << @board[i][i]
      right_left << second_board.reverse[t][t]
      i += 1
      t -= 1
    end

    if left_right.include?(nil) == false && left_right.uniq.size == 1
      round_won(@players[left_right[0]])
    end

    if right_left.include?(nil) == false && right_left.uniq.size == 1
      round_won(@players[right_left[0]])
    end
  end

  def finish
    @finished = true
    print GAME_OVER
    printf(USER_RESULT_MESSAGE, @players[0].name, @players[0].point)
    printf(USER_RESULT_MESSAGE, @players[1].name, @players[1].point)
  end

  def reset
    @board    = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
    @turn     = -1
    @in_queue = @players[PLAYER_X_INDEX]
  end

  def round_won(player)
    put_board
    player.add_point(1) 
    @winner = player
    printf(PLAYER_WON_MESSAGE, @winner.name)
    puts PLAY_AGAIN_MESSAGE
    if gets.chomp.downcase == 'n'
      finish 
    else
      reset
    end
  end

  def draw
    put_board
    print GAME_DRAW_MESSAGE
    print PLAY_AGAIN_MESSAGE
    if gets.chomp.downcase == 'n'
      finish 
    else
      reset
    end
  end
  def board_full
    @board.map(&:compact).flatten.size == 9
  end

  def print_header
    ALPHABET.size.times do |character|
      print (' ' * TITLE_SPACE_BETWEEN).to_s + (character + 1).to_s
    end
    puts
  end
end
