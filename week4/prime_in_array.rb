class AttributeError < StandardError; end
require './validation'
class PrimesArray
  include Validation
  def initialize(numbers)
    @numbers = numbers
  end

  def call
    validate_array
    prime_numbers_count
  rescue AttributeError => e
    warn e
  end

  private

  def validate_array
    integer_lmbda = lambda { |value|
      Validation.validate_with_lambda(value.to_i.to_s == value.to_s && value.to_i.positive?,
                                      "#{value} must be natural!")
    }
    @numbers.map(&integer_lmbda)

    Validation.validate_with_lambda(!@numbers.empty?, 'array must be not empty!')
  end

  def prime_numbers_count
    @numbers.select { |number| prime?(number) }.count
  end

  def prime?(number, current_divisor = 2)
    return false if number.to_i < 2
    return true if number.to_i == 2
    return false if (number.to_i % current_divisor).zero?
    return true if (current_divisor * current_divisor) > number.to_i

    prime?(number, current_divisor + 1)
  end
end

numbers = []
loop do
  puts "please enter number: (to stop enter 'stop')"
  number = gets.chomp
  break if number == 'stop'

  numbers.push(number)
end

puts PrimesArray.new(numbers).call
