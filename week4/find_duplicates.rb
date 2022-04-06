class AttributeError < StandardError; end
require './validation'
class FindDuplicatesInArray
  include Validation
  def initialize(numbers)
    @numbers = numbers
  end

  def call
  validate_numbers
  #find_duplicates
  rescue AttributeError => e
    warn e
  end

  private
  def validate_numbers 
    Validation.validate_with_lambda(!@numbers.empty?, "array must be not empty!")
    integer_lmbda = ->(value){ Validation.validate_with_lambda(value.to_i.to_s == value.to_s, "#{value} must be integer!")}
    @numbers.map(&integer_lmbda)
  end

  def find_duplicates
  #   @numbers.inject({}) do |hash, item|
  #   end
  end
end

numbers = []
while true
  puts "please enter number: (to stop enter 'stop')"
  number = gets.chomp
  break if number == "stop"
  numbers.push(number)
end

FindDuplicatesInArray.new(numbers).call
