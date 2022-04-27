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
    Validation.validate_with_lambda(@number.to_i.to_s == @number.to_s, "#{@number} must be integer!")
    Validation.validate_with_lambda(@number.to_s != '0', "#{@number} must not be zero!")
    Validation.validate_presence(@number, 'number')
  end

  def calculate_factorial
    number_factorial_recursive(@number.to_i)
  end

  def number_factorial_recursive(number)
    return 1 if number == 0

    number * number_factorial_recursive(number - 1)
  end
end

puts 'please enter number to calculate factorial:'
number = gets.chomp
print NumberFactorial.new(number).call
