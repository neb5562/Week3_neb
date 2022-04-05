require 'date'

class OrdinalNum
  def initialize(year, month, day)
    @year, @month, @day = year, month, day
    validate_date(@year, @month, @day)
  end

  def get_ordinal_number
    "Day #{Date.new(@year, @month, @day).yday}."
  end

  private
  def validate_date(year, month, day)
    if Date.valid_date?(year.to_i, month.to_i, day.to_i) == false
      warn "#{year}-#{month}-#{day} Date is not valid!"
      exit 1
    end
  end
end

puts "please enter year:"
year = gets.chomp
puts "please enter month:"
month = gets.chomp
puts "please enter day:"
day = gets.chomp

puts OrdinalNum.new(year, month, day).get_ordinal_number


