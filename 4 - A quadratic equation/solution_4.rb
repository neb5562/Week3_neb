require "../Validation/validation"
MULTIPLY_FIRST_COEFFICIENT = 2
DISCRIMINANT_FORMULA_NUMBER = 4

class Quad
  def initialize(first_coefficient, second_coefficient, third_coefficient)
    @validation = Validation.new
    @validation.validate_type(first_coefficient, Float, "first coefficient")
    @validation.validate_type(second_coefficient, Float, "second coefficient")
    @validation.validate_type(third_coefficient, Float, "third coefficient")
    @validation.check_all_validations
    @first_coefficient = first_coefficient.to_f
    @second_coefficient = second_coefficient.to_f
    @third_coefficient = third_coefficient.to_f
    @discriminant = get_discriminant
  end

  def get_discriminant
    (@second_coefficient * @second_coefficient) - (DISCRIMINANT_FORMULA_NUMBER * @first_coefficient * @third_coefficient)
  end

  def find_elements
    if @discriminant.positive?
      find_element_if_discriminant_positive
    elsif @discriminant.zero?
      find_element_if_discriminant_zero
    else
      puts "Discriminant: #{@discriminant}\n\"No Roots\""
    end
  end

  private
  def find_element_if_discriminant_positive
    x1 = (-@second_coefficient + Math.sqrt(@discriminant)) / (MULTIPLY_FIRST_COEFFICIENT * @first_coefficient)
    x2 = (-@second_coefficient - Math.sqrt(@discriminant)) / (MULTIPLY_FIRST_COEFFICIENT * @first_coefficient)
    puts "Discriminant: #{@discriminant}\nx1: #{x1}\nx2: #{x2}"
  end

  def find_element_if_discriminant_zero
    x1 = -@second_coefficient / (MULTIPLY_FIRST_COEFFICIENT * @first_coefficient)
    puts "Discriminant: #{@discriminant}\nx1=x2=: #{x1}\n"
  end
end

# get data from input
puts 'Please enter first coefficient:'
first_coefficient = gets.chomp
puts 'Please enter second coefficient:'
second_coefficient = gets.chomp
puts 'Please enter third coefficient:'
third_coefficient = gets.chomp

Quad.new(first_coefficient, second_coefficient, third_coefficient).find_elements