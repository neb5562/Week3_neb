require "../Validation/validation"
require 'date'

class OrdinalNum
  def initialize(year, month, day)
    @validation = Validation.new
    @validation.validate_presence(year, "year")
    @validation.validate_presence(month, "month")
    @validation.validate_presence(day, "day")
    @validation.validate_type(year, Integer, "year")
    @validation.validate_type(month, Integer, "month")
    @validation.validate_type(day, Integer, "day")
    @validation.validate_date(year, month, day)
    @validation.check_all_validations
    @year, @month, @day = year.to_i, month.to_i, day.to_i
  end

  def get_ordinal_number
    "Day #{Date.new(@year, @month, @day).yday}."
  end

end

puts "please enter year:"
year = gets.chomp
puts "please enter month:"
month = gets.chomp
puts "please enter day:"
day = gets.chomp

puts OrdinalNum.new(year, month, day).get_ordinal_number
