#!/usr/bin/env ruby
$LOAD_PATH << '../lib'

class AttributeError < StandardError; end
require 'validation'

class StockPicker
  ARRAY_MIN_SIZE            = 2
  EMPTY_ARRAY_MESSAGE       = 'array must be not empty'.freeze
  ARRAY_SIZE_MESSAGE        = 'array size must be over 1'.freeze
  ARRAY_OF_INTEGERS_MESSAGE = 'array must include only integers'.freeze

  include Validation

  def initialize(array)
    @stock_array = array
    @days        = {}
  end

  def call
    validate
    stock_picker
  rescue AttributeError => e
    warn e
  end

  private

  def validate
    Validation.validate_presence(@stock_array, 'array')
    Validation.validate_with_lambda(@stock_array.empty? == false, EMPTY_ARRAY_MESSAGE)
    Validation.validate_with_lambda(@stock_array.size < ARRAY_MIN_SIZE == false, ARRAY_SIZE_MESSAGE)
    Validation.validate_with_lambda(@stock_array.all?{ |num| num.is_a? Integer } == false, ARRAY_OF_INTEGERS_MESSAGE)
  end

  def stock_picker
    @stock_array.map!(&:to_i).each_with_index do |item, index|
      generate_hash(item, index)
    end
    max = @days.max_by { |_key, value| value['difference'] }[1]
    [max['second_index'], max['first_index']]
  end

  def generate_hash(item, index)
    min_item, second_index = @stock_array[0..index].each_with_index.min
    difference = item.to_i - min_item.to_i
    @days[item] = { 'first_index' => index, 'second_index' => second_index, 'difference' => difference }
  end
end

