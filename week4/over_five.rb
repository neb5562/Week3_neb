class AttributeError < StandardError; end
require './validation'
class OverFive
  NUMBER_TO_CHECK = 5
  include Validation
  def initialize(numbers)
    @numbers = numbers
  end

  def call
    validate_array
    numbers_oer_five
  rescue AttributeError => e
    warn e
  end

  private

  def validate_array
    integer_lmbda = lambda { |value|
      Validation.validate_with_lambda(value.to_i.to_s == value.to_s, "#{value} must be integer!")
    }
    @numbers.map(&integer_lmbda)
    Validation.validate_with_lambda(!@numbers.empty?, 'array must be not empty!')
  end

  def numbers_oer_five
    @numbers.select { |number| number.to_i > NUMBER_TO_CHECK }.count
  end
end

numbers = []
loop do
  puts "please enter number: (to stop enter 'stop')"
  number = gets.chomp
  break if number == 'stop'

  numbers.push(number)
end

puts OverFive.new(numbers).call
