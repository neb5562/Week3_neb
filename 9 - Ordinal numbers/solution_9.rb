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

puts OrdinalNum.new(2020, 2, 29).get_ordinal_number
