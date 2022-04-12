#!/usr/bin/env ruby
$LOAD_PATH << './lib'

ARRAY_MIN = 1
ARRAY_MAX = 10

require 'arrmissnum'
require 'faker'

100.times do
  describe ArrMissNum do
    # generates valid arrays of 9 numbers
    it "returns difference number" do
      pop_number = Faker::Number.within(range: ARRAY_MIN..ARRAY_MAX).to_i
      array = (ARRAY_MIN..ARRAY_MAX).to_a - [pop_number]
      expect(ArrMissNum.new(array).call).to eq(pop_number)
    end
    
    # generates invalid arrays of 9 numbers
    it "returns false" do
      sample = ARRAY_TEMPLATE.sample(6)
      array = sample + sample.sample(3)
      expect(ArrMissNum.new(array).call).to be_falsey
    end

  end
end
describe ArrMissNum do
  it "returns false if enter nil" do
    expect(ArrMissNum.new(nil).call).to be_falsey
  end

  it "returns false if enter string" do
    expect(ArrMissNum.new("Asfaa aef").call).to be_falsey
  end

  it "returns false if enter empty array" do
    expect(ArrMissNum.new([]).call).to be_falsey
  end

  it "returns false if enter array with size of not 9" do
    expect(ArrMissNum.new([1,8,4,5]).call).to be_falsey
  end

  it "returns false if enter array with non integer number" do
    expect(ArrMissNum.new([1,2,'3']).call).to be_falsey
  end
end
