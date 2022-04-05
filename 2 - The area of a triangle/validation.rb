module Validation
  REGEX_VALIDATE_NUMBERS = /^-?(?!0\d)\d*(\.\d+)?$/

  def self.validate_number(value, name)
    raise AttributeError, "\e[31m#{name} must be number!\e[0m" unless value.match? (REGEX_VALIDATE_NUMBERS)
  end

  def self.validate_presence(value, name)
    raise AttributeError, "\e[31myou must enter #{name}!\e[0m" if value.to_s.empty?
  end

  def self.validate_range(value, name, range_start = nil, range_end = nil)
    first_check = range_start.nil? ? true : value.to_f >= range_start.to_f
    second_check = range_end.nil? ? true : value.to_f <= range_end.to_f
    raise AttributeError, "\e[31m#{name} must be greater or equal to #{range_start}!\e[0m" unless first_check
    raise AttributeError, "\e[31m#{name} must be less or equal to #{range_end}!\e[0m"  unless second_check
  end

  def self.validate_positive(value, name)
    raise AttributeError, "\e[31m#{name} must be positive!\e[0m" unless value.to_f.positive?
  end

  def self.validate_negative(value, name)
    raise AttributeError, "\e[31m#{name} must be negative!\e[0m" unless value.to_f.negative?
  end

  def validate_date(year, month, day)
    raise AttributeError, "\e[31mdate must be valid!\e[0m" unless Date.valid_date?(year.to_i, month.to_i, day.to_i)
  end
end

