class Triangle
  def initialize(first_side, second_side, third_side)
    @first_side, @second_side, @third_side = [first_side.to_f, second_side.to_f, third_side.to_f].sort!
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
    @first_side == @second_side || @second_side == @third_side || @first_side == @third_side && is_triangle?
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
triangle1.calculate_rectangular_triangle