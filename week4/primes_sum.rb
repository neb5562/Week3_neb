class AttributeError < StandardError; end
require './validation'
class PrimesSum
  TWO_IN_PRIME = 2
  include Validation
  def initialize(numbers)
    @numbers = numbers
  end

  def call
    validate_array
    prime_numbers_sum
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

  def prime_numbers_sum
    @numbers.select { |number| prime?(number) }.sum(&:to_i)
  end

  def prime?(number)
    return false if number.to_i < TWO_IN_PRIME

    (TWO_IN_PRIME..(number.to_i / TWO_IN_PRIME)).none? { |item| (number.to_i % item).zero? }
  end
end

numbers = []
loop do
  puts "please enter number: (to stop enter 'stop')"
  number = gets.chomp
  break if number == 'stop'

  numbers.push(number)
end

puts PrimesSum.new(numbers).call
