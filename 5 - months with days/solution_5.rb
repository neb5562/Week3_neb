require 'date'
require "../Validation/validation"

class NewDate
  NEGATIVE_NUM = -1
  FIRST_MONTH = 1
  LAST_MONTH = 12
  def initialize(year)
    @validation = Validation.new
    @validation.validate_presence(year, "year")
    @validation.validate_type(year, Integer, "year")
    @validation.validate_range(year, 1, nil)
    @validation.check_all_validations
    @year = year
    @months_with_days = generate_months_with_days_count
  end

  # select months of year with 30 days or any value days variable gets.
  def months_with_days(days)
    @validation.validate_presence(days, "day")
    @validation.validate_type(days, Integer, "day")
    @validation.validate_range(days, 1, 31)
    @validation.check_all_validations
    @months_with_days.select{ |_, days_in_month| days_in_month == days }
  end

  private
  def generate_months_with_days_count
    months_with_days = {}
    (FIRST_MONTH..LAST_MONTH).each do |i|
      months_with_days[Date::MONTHNAMES[i].to_s] = Date.new(@year, i, NEGATIVE_NUM).day
    end
    months_with_days
  end
end

# calculate for year of 2022 and months with 30 days
puts NewDate.new(2022).months_with_days(30)
