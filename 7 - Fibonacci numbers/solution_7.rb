FIBONACI_COUNT = 100

class Fibonaci
  def initialize
    @first_number = 0
    @second_number = 1
    @numbers = generate_numbers
  end

  def generate_numbers
    numbers = []
    numbers.push(@first_number)
    FIBONACI_COUNT.times do
      @first_number, @second_number = @second_number, @first_number + @second_number
      numbers.push(@first_number)
    end
    numbers
  end

  def get_numbers 
    return @numbers
  end
end

fib = Fibonaci.new
puts fib.get_numbers