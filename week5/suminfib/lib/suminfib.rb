#!/usr/bin/env ruby
$LOAD_PATH << '../lib'

class AttributeError < StandardError; end
require 'validation'

class SumInFib
  include Validation
  def initialize(range_start, range_end)
    @range_start = range_start
    @range_end   = range_end
  end

  def call
    validate
    sum
  rescue AttributeError => e
    warn e
    return false
  end

  private

  def validate
    Validation.validate_presence(@range_start, "start range")
    Validation.validate_presence(@range_end, "end range")
    Validation.validate_natural_number(@range_start, "start range")
    Validation.validate_natural_number(@range_end, "end range")
    Validation.validate_with_lambda(@range_start <= @range_end, "first number must be less than second")
  end

  def sum
    first_number  = 0
    second_number = 1
    sum_array = Array.new

    while second_number < @range_end.to_i do
      sum_array << second_number if second_number.even?
      first_number,second_number = second_number, first_number + second_number
    end

    sum_array.select{ |item| item >= @range_start.to_i && item <= @range_end.to_i }.sum
  end
end
