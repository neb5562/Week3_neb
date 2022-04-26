#!/usr/bin/env ruby
$LOAD_PATH << '../lib'

class AttributeError < StandardError; end
require_relative 'validation'
require_relative 'player'
require_relative 'board'

class TicTacToe
  attr_accessor :players, :board, :player_in_queue, :turn
  extend Validation

  ALPHABET                    = %w[a b c].freeze
  ALPHABET_INDEXES            = ALPHABET.each_with_index.map{ |v,k| k + 1 }
  TITLE_SPACE_BETWEEN         = 4
  COLOR_RED_START             = "\e[31m".freeze
  COLOR_GREEN_START           = "\e[32m".freeze
  COLOR_END                   = "\e[0m".freeze
  INPUT_STRING_LENGTH         = 2
  INPUT_STRING_LENGTH_MESSAGE = "\nmove input must be #{INPUT_STRING_LENGTH} characters!"
  STOP_GAME_COMMAND           = 'end'.freeze
  NO_NEW_GAME_COMMAND         = 'n'.freeze
  NEW_GAME_COMMAND            = 'y'.freeze
  MESSAGE_TO_USER             = "\n%s, please enter index to fill: (example 'a1'), to end game enter: 'end'\n".freeze
  GAME_OVER                   = "\nGame Over!\n".freeze
  USER_RESULT_MESSAGE         = "%s: %d points\n".freeze
  PLAY_AGAIN_MESSAGE          = "Play again? (y/n):\n".freeze
  PLAYER_WON_MESSAGE          = "Player %s won!\n".freeze
  GAME_DRAW_MESSAGE           = "\nIt's draw!\n".freeze
  INVALID_INPUT               = "\nInvalid Input!\n".freeze
  ALREADY_FILLED_MESSAGE      = "\nblock already filled!".freeze
  INPUT_PLAYER_NAME_MESSAGE   = "please enter player %s name: ".freeze
  PLAYERS_COUNT               = 2

  def initialize
    @players                 = []
    @board                   = Board.new([[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]])
    @turn                    = 0
    @finished                = false
    @winner                  = nil
    @player_in_queue         = nil
    @current_input           = nil
  end

  def call
    until @players.size == PLAYERS_COUNT do
      get_player
    end
    run
  rescue AttributeError => e
    e.message
  end

  def get_action
    gets.chomp
  end

  def run 
    until @finished
      put_board
      get_turn
      save_turn
      line =  @board.winner_line?
      round_won(@players[line]) if line 
      draw if @board.full? && @winner.nil?
      increase_turn
      queue_player
    end
  end

  def save_turn
    @player_in_queue.add_move(@turn, @current_input)
    @board.fill_board(get_indexes, @turn.modulo(2))
  end

  def increase_turn
    @turn += 1
  end

  def decrease_turn
    @turn -= 1
  end

  def add_player(player)
    size = @players.size
    if player.valid?
      @players << player 
      @player_in_queue ||= @players[0]
    end
    @players.size > size
  end

  def get_indexes
    player_moves = @player_in_queue.moves
    index1 = ALPHABET.index(player_moves[player_moves.keys.last][0].downcase).to_i
    index2 = player_moves[player_moves.keys.last][1].to_i - 1
    [index1, index2]
  end

  def validate(input)
    validations = []
    validations << Validation.validate_presence(input, "'move'")
    check_indexes = ALPHABET.include?(input[0].to_s) && ALPHABET_INDEXES.include?(input[1].to_i)
    validations << Validation.validate_with_lambda(check_indexes, INVALID_INPUT)
    validations << Validation.validate_with_lambda(input.length == INPUT_STRING_LENGTH, INPUT_STRING_LENGTH_MESSAGE)
    indexes = [ALPHABET.index(input[0].downcase).to_i, input[1].to_i - 1]
    validations << Validation.validate_with_lambda(@board.can_fill(indexes), INVALID_INPUT)
    !validations.include? false
  end
  
  def queue_player
    @player_in_queue = @players[@turn.modulo(2)]
  end

  private

  def get_turn
    loop do
      printf(MESSAGE_TO_USER, @player_in_queue.name)
      @current_input = get_action
      check_finish(@current_input)
      break if validate(@current_input) != false
    end
  end
  
  def get_player
    printf(INPUT_PLAYER_NAME_MESSAGE, @players.size.next)
    name = get_action
    add_player(Player.new(name, @players.size))
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
      index += 1
      puts
    end
  end

  def print_line(line, index)
    print "#{ALPHABET[index]} "
    line.each do |symb|
      print_symbol(symb)
    end
  end

  def print_symbol(symb)
    if symb.nil?
      print '|   |' 
    else
      color = symb.zero? ? COLOR_RED_START : COLOR_GREEN_START
      print "| #{color}#{Board::SYMBOLS[symb]}#{COLOR_END} |"
    end
    
  end

  def finish
    @finished = true
    print GAME_OVER
    printf(USER_RESULT_MESSAGE, @players[0].name, @players[0].point)
    printf(USER_RESULT_MESSAGE, @players[1].name, @players[1].point)
    exit false
  end

  def check_finish(input)
    finish if input.downcase == STOP_GAME_COMMAND
  end

  def reset
    @board.reset
    decrease_turn
    @player_in_queue = @players[0]
  end

  def round_won(player)
    put_board
    player.add_point(1) 
    @winner = player
    printf(PLAYER_WON_MESSAGE, @winner.name)
    play_again?
  end

  def draw
    put_board
    print GAME_DRAW_MESSAGE
    play_again?
  end

  def play_again?
    inputs = [NO_NEW_GAME_COMMAND, NEW_GAME_COMMAND]
    loop do
      print PLAY_AGAIN_MESSAGE
      input = get_action.downcase
      finish if input == NO_NEW_GAME_COMMAND
      reset if input == NEW_GAME_COMMAND
      break if inputs.include?(input)
    end
  end
end
