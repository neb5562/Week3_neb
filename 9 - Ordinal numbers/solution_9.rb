require 'date'

class OrdinalNum
  def initialize(year, month, day)
    @year, @month, @day = validate_int(year), validate_int(month), validate_int(day)
  end

  def get_ordinal_number
    "Day #{Date.new(@year, @month, @day).yday}."
  end

  private
  def validate_int(value)
    if value.to_s.match(/^\d+$/)
      value.to_i
    else
      warn "#{value} must be Integer value!"
      exit 1
    end
  end
end

puts OrdinalNum.new("asd", 3, 12).get_ordinal_number
