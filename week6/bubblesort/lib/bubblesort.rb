#!/usr/bin/env ruby
$LOAD_PATH << '../lib'

class AttributeError < StandardError; end
require 'validation'

class BubbleSort
  extend Validation
  attr_reader :array
  EMPTY_ARRAY_MESSAGE       = 'array must be not empty'.freeze
  ARRAY_OF_INTEGERS_MESSAGE = 'array must include only integers'.freeze
  def initialize(array)
    @array = array
  end

  def call
    validate
    bubble_sort
  rescue AttributeError => e
    e.message
  end

  private

  def validate
    Validation.validate_with_lambda(@array.empty? == false, EMPTY_ARRAY_MESSAGE)
    Validation.validate_with_lambda(@array.all?{ |num| num.is_a? Integer }, ARRAY_OF_INTEGERS_MESSAGE)
  end

  def bubble_sort
    loop do
      current_array = @array.dup
      @array.each_with_index do |number, index|
        if  @array[index + 1] && @array[index] > @array[index + 1]
          @array[index], @array[index + 1] = @array[index + 1], @array[index]
        end
      end
      break if current_array == @array
    end
    @array
  end
end
