require './validation'
FIXED_VALUE_TO_SUBSCRAPT = 110

class Person
  def initialize(name, height)
    @validation = Validation.new
    @name = name
    @validation.validate_presence_of(@name, "name")
    @height = height
    @validation.validate_presence_of(@height, "height")
    @validation.validate_int(@height, "height")
    @validation.check_all_validations
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

person = Person.new name, height
puts person.get_ideal_weight
