#!/usr/bin/env ruby
$LOAD_PATH << '../lib'

class AttributeError < StandardError; end
require 'validation'

SUBSTR_UPPERCASE = 65
SUBSTR_DOWNCASE  = 97
MAX_DOWNCASE     = 122
MAX_UPCASE       = 90
ALPHABET_REGEX   = /[[:alpha:]]/.freeze

class Caesar
  extend Validation
  def initialize(str, shift)
    @str   = str
    @shift = shift
  end

  def call
    validate
    encode
  rescue AttributeError => e
    warn e
  end

  private

  def validate
    Validation.validate_presence(@str, 'string')
    Validation.validate_presence(@shift, 'shift number')
    Validation.validate_natural_number(@shift, 'number')
  end

  def encode
    temp_string = String.new
    @str.split('').map do |char|
      # if char is part of alphabet
      if char.match?(ALPHABET_REGEX)
        # check if downcase or upcase
        if char.ord.between?(SUBSTR_DOWNCASE, MAX_DOWNCASE)
          to_skip = SUBSTR_DOWNCASE
          char.downcase
        else
          to_skip = SUBSTR_UPPERCASE
          char.upcase
        end
        temp_string << ((((char.ord - to_skip) + @shift.to_i) % 26) + to_skip).chr
      else
        temp_string << char
      end
    end
    temp_string
  end
end
