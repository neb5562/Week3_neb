INCREMENT_FROM = 10
INCREMENT_TO = 100
INCREMENT_BY = 5

class IncNums
  def initialize
    @array_of_numbers = generate_numbers
  end

  def generate_numbers
    (INCREMENT_FROM..INCREMENT_TO).step(INCREMENT_BY).to_a
  end

  def get_array
    @array_of_numbers
  end
end

puts IncNums.new.get_array

