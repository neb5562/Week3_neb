#!/usr/bin/env ruby
$LOAD_PATH << '../lib'

class AttributeError < StandardError; end
require 'validation'
ARRAY_TEMPLATE = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].freeze

class ArrMissNum
  include Validation
  MAX_NUMBER = 10
  MIN_NUMBER = 1
  USER_INPUT_ARR_SIZE = 9

  def initialize(input_array)
    @input_array = input_array 
  end

  def call
    validate_array
    find_missing_num
  rescue AttributeError => e
    warn e

    return false
  end

  private

  def validate_array
    Validation.validate_presence(@input_array, "array")
    Validation.validate_with_lambda(@input_array.kind_of?(Array), "must be array")
    Validation.validate_with_lambda(@input_array.all?{ |num| num.is_a? Integer }, "must be array of integers")
    Validation.validate_with_lambda(@input_array.length == USER_INPUT_ARR_SIZE, "size of a array must be 9")
    Validation.validate_with_lambda(find_missing_num.between?(MIN_NUMBER,MAX_NUMBER), "invalid array")
  end

  def find_missing_num
    (ARRAY_TEMPLATE - @input_array).join.to_i
  end
end
