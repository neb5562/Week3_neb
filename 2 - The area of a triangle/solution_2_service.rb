class Triangle
  require "./validation"
  TRIANGLE_AREA_ONE = 1
  TRIANGLE_AREA_TWO = 2

  def initialize(base, height)
    @validation = Validation.new  
    @validation.validate_presence(base, "base")
    @validation.validate_type(base, Float, "base")
    @validation.validate_presence(height, "height")
    @validation.validate_type(height, Float, "height")
    @validation.check_all_validations
    @base = base.to_f
    @height = height.to_f
  end
  
  def call 
    get_area_of_triangle
  end

  private
  def get_area_of_triangle
    @base * @height * TRIANGLE_AREA_ONE / TRIANGLE_AREA_TWO
  end
end

puts "Please enter base of a triangle:"
base = gets.chomp
puts "Please enter height of a triangle:"
height = gets.chomp
triangle1 = Triangle.new(base, height)
puts triangle1.call

