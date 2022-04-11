class AttributeError < StandardError; end
require 'validation'

class RepDigit
  include Validation

  def initialize(digit)
    @digit = digit
  end

  def call
    validate_digit
    repdigit?
  end

  private

  def validate_digit
    Validation.validate_presence(@digit, 'number')
    Validation.validate_natural_number(@digit, 'number')
  end

  def repdigit?
    @digit.to_s.split("").uniq.length == 1
  end
end
