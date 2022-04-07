class AttributeError < StandardError; end
require './validation'
class DigitsSum
  include Validation
  def initialize(number_start, number_end)
    @number_start = number_start
    @number_end = number_end
  end

  def call
    validate_numbers
    calculate_sum
  rescue AttributeError => e
    warn e
  end

  private

  def validate_numbers
    Validation.validate_presence(@number_start, 'starting number')
    Validation.validate_presence(@number_end, 'ending number')
    Validation.validate_with_lambda(@number_start.to_i.to_s == @number_start.to_s, "#{@number_start} must be integer!")
    Validation.validate_with_lambda(@number_end.to_i.to_s == @number_end.to_s, "#{@number_end} must be integer!")
  end

  def calculate_sum
    (@number_start.to_i..@number_end.to_i).inject(:+)
  end
end

puts 'please enter starting number:'
number_start = gets.chomp
puts 'please enter ending number:'
number_end = gets.chomp

puts DigitsSum.new(number_start, number_end).call
