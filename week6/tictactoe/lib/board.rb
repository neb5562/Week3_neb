class Board
  attr_reader :board

  ALREADY_FILLED_MESSAGE = 'block already filled!'.freeze

  def initialize(board)
    @board = board
  end

  def reset
    @board = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
  end


  def full?
    @board.map(&:compact).flatten.size == 9
  end

  def winner_line?
    left_right = []
    right_left = []
    i = 0
    t = @board.size - 1

    @board.each do |array|
      next unless array.include?(nil) == false && array.uniq.size == 1

      return array[0]
    end

    second_board = @board.dup.transpose
    second_board.each do |array|
      next unless array.include?(nil) == false && array.uniq.size == 1

      return array[0]
    end

    @board.size.times do
      left_right << @board[i][i]
      right_left << second_board.reverse[t][t]
      i += 1
      t -= 1
    end

    if left_right.include?(nil) == false && left_right.uniq.size == 1
      return left_right[0]
    end

    if right_left.include?(nil) == false && right_left.uniq.size == 1
      return right_left[0]
    end

    return false
  end

  def fill_board(index1, index2, value)
    Validation.validate_with_lambda(@board[index1][index2].nil?, ALREADY_FILLED_MESSAGE)
    @board[index1][index2] = value
  end
end
