class AttributeError < StandardError; end
class Triangle
  require "./validation"
  include Validation
  def initialize(first_side, second_side, third_side)
    @first_side, @second_side, @third_side = [first_side, second_side, third_side].sort!
  end

  def call 
    proceed_validations
    calculate_rectangular_triangle
  rescue AttributeError => e
    warn e
  end

  private
  def proceed_validations
    Validation.validate_presence(@first_side, "first side")
    Validation.validate_presence(@second_side, "second side")
    Validation.validate_presence(@third_side, "third side")
    Validation.validate_number(@first_side, "first side")
    Validation.validate_number(@second_side, "second side")
    Validation.validate_number(@third_side, "third side")
    Validation.validate_positive(@first_side, "first side")
    Validation.validate_positive(@second_side, "second side")
    Validation.validate_positive(@third_side, "third side")
  end

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
    first_check = (@first_side.to_f + @second_side.to_f) > @third_side.to_f
    second_check = (@second_side.to_f + @third_side.to_f) > @first_side.to_f
    thitd_check = (@third_side.to_f + @first_side.to_f) > @second_side.to_f
    
    (first_check && second_check && thitd_check)
  end

  # check if triangle is pythagorean && valid
  def is_pythagorean?
    @first_side.to_f**2 + @second_side.to_f**2 == @third_side.to_f**2 && is_triangle?
  end

  # check if triangle is isosceles && valid
  def is_isosceles?
    first_check = @first_side.to_f == @second_side.to_f
    second_check = @second_side.to_f == @third_side.to_f
    thitd_check = @first_side.to_f == @third_side.to_f
    
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


triangle1 = Triangle.new(first_side, second_side, third_side)
triangle1.call

