require 'date'

class OrdinalNum
  def initialize year, month, day
    @year, @month, @day = year, month, day
  end

  def get_ordinal_number
    "Day #{Date.new(@year, @month, @day).yday}."
  end
end

puts OrdinalNum.new(2022, 3, 12).get_ordinal_number