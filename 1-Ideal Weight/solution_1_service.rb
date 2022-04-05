class Person
  require './validation'
  FIXED_VALUE_TO_SUBSCRAPT = 110
  
  def initialize(name, height)
    @validation = Validation.new
    @validation.validate_presence(name, "name")
    @validation.validate_presence(height, "height")
    @validation.validate_type(height, Integer, "height")
    @validation.validate_range(height, "height", 0)
    @validation.check_all_validations
    @height = height
    @name = name
  end

  def call 
    get_ideal_weight
  end
  
  private
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
puts person.call
