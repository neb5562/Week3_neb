class AttributeError < StandardError; end
require './validation'
class NumberFactorial
  include Validation
  def initialize(number)
    @number = number
  end

  def call
    validate_number
    calculate_factorial
  rescue AttributeError => e
    warn e
  rescue SystemStackError => e
    warn e
  end

  private

  def validate_number
    Validation.validate_positive(@number, 'number')
  end

  def calculate_factorial
    number_factorial_recursive(@number.to_i)
  end

  def number_factorial_recursive(number)
    return number if number == 1

    number * number_factorial_recursive(number - 1)
  end
end

puts 'please enter number to calculate factorial:'
number = gets.chomp
print NumberFactorial.new(number).call
