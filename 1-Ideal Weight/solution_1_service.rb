class AttributeError < StandardError; end
class Person
  require "./validation"
  include Validation
  FIXED_VALUE_TO_SUBSCRAPT = 110
  
  def initialize(name, height)
    @height = height
    @name = name
  end

  def call 
    proceed_validations
    get_ideal_weight
  rescue AttributeError => e
    warn e
  end
  
  private
  def proceed_validations
    Validation.validate_presence(@name, "name")
    Validation.validate_presence(@height, "height")
    Validation.validate_number(@height, "height")
    Validation.validate_range(@height, "height", 0)
  end

  def get_ideal_weight
    @ideal_weight = @height.to_i - FIXED_VALUE_TO_SUBSCRAPT
    'Your weight is already optimal' if @ideal_weight.negative?
    "Name: #{@name}\nHeight: #{@height}\nIdeal weight: #{@ideal_weight}"
  end
end


puts 'Please enter your name:'
name = gets.chomp
puts 'Please enter your height:'
height = gets.chomp

person = Person.new(name, height)
puts person.call
