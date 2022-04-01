require "./validation"
TRIANGLE_AREA_ONE = 1
TRIANGLE_AREA_TWO = 2

class Triangle
  def initialize(base, height)
    @validation = Validation.new  
    @validation.validate_presence_of(base, "base")
    @validation.validate_float(base, "base")
    @validation.validate_presence_of(height, "height")
    @validation.validate_float(height, "height")
    @validation.check_all_validations
    @base = base.to_f
    @height = height.to_f
  end
  
  def get_area_of_triangle
    @base * @height * TRIANGLE_AREA_ONE / TRIANGLE_AREA_TWO
  end
end


triangle1 = Triangle.new("d", 3)
puts triangle1.get_area_of_triangle
