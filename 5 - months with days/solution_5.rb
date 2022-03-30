require 'date'
NEGATIVE_NUM = -1

class Dote
  def initialize(year)
    @year = year
    @months_with_days = generate_months_with_days_count
  end

  def generate_months_with_days_count
    months_with_days = {}
    (1..12).each do |i|
      months_with_days[Date::MONTHNAMES[i].to_s] = Date.new(@year, i, NEGATIVE_NUM).day
    end
    months_with_days
  end

  # select months of year with 30 days or any value days variable gets.
  def get_months_with_days days
    @months_with_days.select{ |month_name, days_in_month| days_in_month == days }
  end
end

# calculate for year of 2022 and months with 30 days
puts Dote.new(2022).get_months_with_days(30)