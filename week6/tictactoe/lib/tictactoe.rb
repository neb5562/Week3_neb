#!/usr/bin/env ruby
$LOAD_PATH << '../lib'

class AttributeError < StandardError; end
require_relative 'validation'
require_relative 'player'
require_relative 'board'

class TicTacToe
  extend Validation

  ALPHABET            = %w[a b c].freeze
  ALPHABET_INDEXES    = ALPHABET.each_with_index.map{ |v,k| k + 1 }
  TITLE_SPACE_BETWEEN = 4
  COLOR_RED_START     = "\e[31m".freeze
  COLOR_GREEN_START   = "\e[32m".freeze
  COLOR_END           = "\e[0m".freeze
  INPUT_STRING_LENGTH = 2
  STOP_GAME_COMMAND   = 'end'.freeze
  NO_NEW_GAME_COMMAND = 'n'.freeze
  NEW_GAME_COMMAND    = 'y'.freeze
  MESSAGE_TO_USER     = "\n%s, please enter index to fill: (example 'a1'), to end game enter: 'end'\n".freeze
  GAME_OVER           = "\nGame Over!\n".freeze
  USER_RESULT_MESSAGE = "%s: %d points\n".freeze
  PLAY_AGAIN_MESSAGE  = "Play again? (y/n):\n".freeze
  PLAYER_WON_MESSAGE  = "Player %s won!\n".freeze
  GAME_DRAW_MESSAGE   = "\nIt's draw!\n".freeze
  INVALID_INPUT       = "Invalid Input!\n".freeze

  def initialize(player1, player2)
    @players                 = []
    @players[Player::PLAYER_X_INDEX] = Player.new(player1)
    @players[Player::PLAYER_O_INDEX] = Player.new(player2)
    @board                   = Board.new([[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]])
    @turn                    = 0
    @finished                = false
    @winner                  = nil
    @in_queue                = @players[Player::PLAYER_X_INDEX]
    @moves                   = []
  end

  def call
    run
  rescue AttributeError => e
    e.message
  end

  private

  def run 
    until @finished
      validate_players()
      put_board()
      printf(MESSAGE_TO_USER, @in_queue.name)
      input = gets.chomp
      check_finish(input)
      validate(input)
      @moves << input
      index1 = ALPHABET.index(@moves.last[0].downcase).to_i
      index2 = @moves.last[1].to_i - 1
      @board.fill_board(index1, index2, @turn.modulo(2) == 1 ? 0 : 1)
      line =  @board.winner_line?
      round_won(@players[line]) if line 
      draw() if @board.full? && @winner.nil?
      @turn += 1
      queue_player()
    end
  end

  def validate(input)
    Validation.validate_presence(input, "'move'")
    Validation.validate_with_lambda(ALPHABET.include?(input[0]), INVALID_INPUT)
    Validation.validate_with_lambda(ALPHABET_INDEXES.include?(input[1].to_i), INVALID_INPUT)
    Validation.validate_with_lambda(input.length == INPUT_STRING_LENGTH, INVALID_INPUT)
  end

  def validate_players
    Validation.validate_presence(@players[Player::PLAYER_X_INDEX].name, "name")
    Validation.validate_presence(@players[Player::PLAYER_O_INDEX].name, "name")
  end

  def print_header
    ALPHABET.size.times do |character|
      print (' ' * TITLE_SPACE_BETWEEN).to_s + (character + 1).to_s
    end
    puts
  end

  def put_board
    index = 0
    print_header
    @board.board.each do |item|
      print_line(item, index)
    end
  end

  def print_line(line, index)
    print "#{ALPHABET[index]} "
    line.each do |symb|
      print_symbol(symb)
    end
    index += 1
    puts
  end

  def print_symbol(symb)
    print '|   |' if symb.nil?
    print "| #{COLOR_RED_START}X#{COLOR_END} |" if symb == Player::PLAYER_X_INDEX
    print "| #{COLOR_GREEN_START}O#{COLOR_END} |" if symb == Player::PLAYER_O_INDEX
  end

  def queue_player
    @in_queue = @players[@turn.modulo(2)]
  end

  def finish
    @finished = true
    print GAME_OVER
    printf(USER_RESULT_MESSAGE, @players[Player::PLAYER_O_INDEX].name, @players[Player::PLAYER_O_INDEX].point)
    printf(USER_RESULT_MESSAGE, @players[Player::PLAYER_X_INDEX].name, @players[Player::PLAYER_X_INDEX].point)
    exit false
  end

  def check_finish(input)
    finish if input.downcase == STOP_GAME_COMMAND
  end

  def reset
    @board.reset
    @turn     = -1
    @in_queue = @players[Player::PLAYER_X_INDEX]
  end

  def round_won(player)
    put_board
    player.add_point(1) 
    @winner = player
    printf(PLAYER_WON_MESSAGE, @winner.name)
    puts PLAY_AGAIN_MESSAGE
    play_again?
  end

  def draw
    put_board
    print GAME_DRAW_MESSAGE
    print PLAY_AGAIN_MESSAGE
    play_again?
  end

  def play_again?
    reset
    input = gets.chomp.downcase
    if input == NO_NEW_GAME_COMMAND
      finish 
    elsif input == NEW_GAME_COMMAND
      reset
    else
      print INVALID_INPUT
      finish
    end
  end
end
