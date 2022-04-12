#!/usr/bin/env ruby
$LOAD_PATH << './lib'

require 'repdigit'
require 'faker'
require 'random_number_helper'
include RandNumHelper


SYMBOLS_NUMBER_FROM = 1
SYMBOLS_NUMBER_TO = 999

NUMBER_CHAR_FROM = 0
NUMBER_CHAR_TO = 9

GENERATE_MIN = 1
GENERATE_MAX = 1_000_000

STRING_LEN_FROM = 1
STRING_LEN_TO = 30


100.times do
  describe RepDigit do

    # must raise AttributeError fo ar negative numbers as it will not pass validation
    it "returns false" do
      expect(RepDigit.new(Faker::Number.negative).call).to be_falsey
    end

    # will generate random numbers like 3333333, 555555555555555, 22222222. all msut be true
    it "returns true" do
      symbol = Faker::Number.within(range: NUMBER_CHAR_FROM..NUMBER_CHAR_TO).to_s
      number = rand(SYMBOLS_NUMBER_FROM...SYMBOLS_NUMBER_TO).to_i
      expect(RepDigit.new(symbol * number).call).to be_truthy
    end

    # will generate non repdigit numbers, with helper
    it "returns false" do
      expect(RepDigit.new(RandNumHelper::non_repdigit_number).call).to be_falsey
    end

    # will generate random string
    it "returns false" do
      expect(RepDigit.new(Faker::String.random).call).to be_falsey
    end
  end
end

#empty value or nil
describe RepDigit do
  it "raises AttributeError" do
    expect(RepDigit.new('').call).to be_falsey
  end

  it "raises AttributeError" do
    expect(RepDigit.new(nil).call).to be_falsey
  end
end
