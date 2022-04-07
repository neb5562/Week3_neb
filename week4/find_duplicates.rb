class AttributeError < StandardError; end
require './validation'
class FindDuplicatesInArray
  include Validation
  def initialize(numbers)
    @numbers = numbers
  end

  def call
  validate_numbers
  find_duplicates
  rescue AttributeError => e
    warn e
  end

  private
  def validate_numbers 
    integer_lmbda = ->(value){ Validation.validate_with_lambda(value.to_i.to_s == value.to_s, "#{value} must be integer!")}
    @numbers.map(&integer_lmbda)
    Validation.validate_with_lambda(!@numbers.empty?, "array must be not empty!")
  end

  def find_duplicates
    @numbers.select{ |number| @numbers.count(number) > 1}.uniq
  end
end

numbers = []
while true
  puts "please enter number: (to stop enter 'stop')"
  number = gets.chomp
  break if number == "stop"
  numbers.push(number)
end

print FindDuplicatesInArray.new(numbers).call
