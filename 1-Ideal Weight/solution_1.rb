FIXED_VALUE_TO_SUBSCRAPT = 110

class Person
  def initialize(name, height)
    @validations = []
    @name = name
    validate_presence_of(@name, "name")
    @height = height
    validate_presence_of(@height, "height")
    validate_int(@height)
    check_all_validations
  end
  
  def get_ideal_weight
    @ideal_weight = @height.to_i - FIXED_VALUE_TO_SUBSCRAPT
    'Your weight is already optimal' if @ideal_weight.negative?
    "Name: #{@name}\nHeight: #{@height}\nIdeal weight: #{@ideal_weight}"
  end

  private
  def validate_int(number)
    if number.to_i.to_s != number
      @validations.push("#{number.to_s + " "}must be integer!")
    else
      return number.to_i
    end
  end

  def validate_presence_of(value, name)
    if value.empty? == true
      @validations.push("you must enter #{name}")
    end
  end

  def check_all_validations
    if @validations.empty? == false
      @validations.each do |message|
        puts message
      end
      exit 1
    end
  end
end


puts 'Please enter your name:'
name = gets.chomp
puts 'Please enter your height:'
height = gets.chomp

person = Person.new name, height
puts person.get_ideal_weight
