#!/usr/bin/env ruby
$LOAD_PATH << '../lib'

class AttributeError < StandardError; end
require 'validation'
ARRAY_TEMPLATE = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].freeze

class ArrMissNum
  extend Validation
  MAX_NUMBER                = 10
  MIN_NUMBER                = 1
  USER_INPUT_ARR_SIZE       = 9
  INPUT_OBJECT              = 'array'.freeze
  NOT_ARRAY_MESSAGE         = 'must be array'.freeze
  ARRAY_OF_INTEGERS_MESSAGE = 'must be array of integers'.freeze
  ARRAY_SIZE_MESSAGE        = 'size of a array must be 9'.freeze
  INVALID_ARRAY_MESSAGE     = 'invalid array'.freeze

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
    Validation.validate_presence(@input_array, INPUT_OBJECT)
    Validation.validate_with_lambda(@input_array.kind_of?(Array), NOT_ARRAY_MESSAGE)
    Validation.validate_with_lambda(@input_array.all?{ |num| num.is_a? Integer }, ARRAY_OF_INTEGERS_MESSAGE)
    Validation.validate_with_lambda(@input_array.length == USER_INPUT_ARR_SIZE, ARRAY_SIZE_MESSAGE)
    Validation.validate_with_lambda(find_missing_num.between?(MIN_NUMBER,MAX_NUMBER), INVALID_ARRAY_MESSAGE)
  end

  def find_missing_num
    (ARRAY_TEMPLATE - @input_array).join.to_i
  end
end
