#!/usr/bin/env ruby
$LOAD_PATH << './lib'

require 'suminfib'
require 'faker'

FIB_NUM_RANGE_START = 0
FIB_NUM_RANGE_END = 999

100.times do
  describe SumInFib do

    it "to return integer type value" do
      range_start = Faker::Number.between(from: FIB_NUM_RANGE_START, to: FIB_NUM_RANGE_END)
      range_end = range_start + rand(1..FIB_NUM_RANGE_END)
      expect(SumInFib.new(range_start, range_end).call).to be_a_kind_of(Integer)
    end

  end
end

describe SumInFib do

  #if first number is greater than second number
  it "returns false" do
    range_start = Faker::Number.between(from: FIB_NUM_RANGE_START, to: FIB_NUM_RANGE_END)
    range_end = range_start + rand(1..FIB_NUM_RANGE_END)
    expect(SumInFib.new(range_end, range_start).call).to be_falsey
  end

    #if both arguments is nil
    it "returns false" do
      expect(SumInFib.new(nil, nil).call).to be_falsey
    end

    #if one argument is nil and second is number
    it "returns false" do
      number = Faker::Number.between(from: FIB_NUM_RANGE_START, to: FIB_NUM_RANGE_END)
      expect(SumInFib.new(nil, number).call).to be_falsey
    end

    # bot empty
    it "returns false" do
      expect(SumInFib.new('', '').call).to be_falsey
    end
end
