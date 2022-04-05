class AttributeError < StandardError; end
class Triangle
  require "./validation"
  include Validation
  
  TRIANGLE_AREA_ONE = 1
  TRIANGLE_AREA_TWO = 2

  def initialize(base, height)
    @base = base
    @height = height
  end
  
  def call 
    proceed_validations
    get_area_of_triangle
  rescue AttributeError => e
    warn e
  end

  private
  def proceed_validations
    Validation.validate_presence(@base, "base")
    Validation.validate_number(@base, "base")
    Validation.validate_presence(@height, "height")
    Validation.validate_number(@height, "height")
  end

  def get_area_of_triangle
    @base.to_f * @height.to_f * TRIANGLE_AREA_ONE / TRIANGLE_AREA_TWO
  end
end

puts "Please enter base of a triangle:"
base = gets.chomp
puts "Please enter height of a triangle:"
height = gets.chomp
triangle1 = Triangle.new(base, height)
puts triangle1.call

