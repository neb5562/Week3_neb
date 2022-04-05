class Triangle
  require "./validation"
  
  def initialize(first_side, second_side, third_side)
    @validation = Validation.new
    @validation.validate_presence(first_side, "first side")
    @validation.validate_presence(second_side, "second side")
    @validation.validate_presence(third_side, "third side")
    @validation.validate_type(first_side, Float, "first side")
    @validation.validate_type(second_side, Float, "second side")
    @validation.validate_type(third_side, Float, "third side")
    @validation.validate_positive(first_side, "first side")
    @validation.validate_positive(second_side, "second side")
    @validation.validate_positive(third_side, "third side")
    @validation.check_all_validations
    @first_side, @second_side, @third_side = [first_side.to_f, second_side.to_f, third_side.to_f].sort!
  end

  def call 
    calculate_rectangular_triangle
  end

  private
  def calculate_rectangular_triangle
    if is_pythagorean? && !is_isosceles?
      puts "Triangle is rectangular triangle.\n"
    else
      puts "Triangle is not rectangular.\n"
    end

    # check if triangle is isosceles
    if is_isosceles?
      puts "Triangle is #{'also ' if is_pythagorean? && is_isosceles?}isosceles.\n"
    end
  end

  # check if triangle is valid
  def is_triangle?
    first_check = (@first_side + @second_side) > @third_side
    second_check = (@second_side + @third_side) > @first_side
    thitd_check = (@third_side + @first_side) > @second_side
    
    (first_check && second_check && thitd_check)
  end

  # check if triangle is pythagorean && valid
  def is_pythagorean?
    @first_side**2 + @second_side**2 == @third_side**2 && is_triangle?
  end

  # check if triangle is isosceles && valid
  def is_isosceles?
    first_check = @first_side == @second_side
    second_check = @second_side == @third_side
    thitd_check = @first_side == @third_side
    
    first_check || second_check || thitd_check && is_triangle?
  end
end

# get data from input
puts 'Please enter first side:'
first_side = gets.chomp
puts 'Please enter second side:'
second_side = gets.chomp
puts 'Please enter third side:'
third_side = gets.chomp


triangle1 = Triangle.new first_side, second_side, third_side
triangle1.call

