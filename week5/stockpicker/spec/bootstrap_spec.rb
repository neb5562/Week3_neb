#!/usr/bin/env ruby
$LOAD_PATH << './lib'

require 'stockpicker'
require 'faker'

context StockPicker do
  let(:stocks) { [17, 3, 6, 9, 15, 8, 6, 1, 10] }
  let(:empty_array) { [] }
  let(:invalid_array) { [2,35,7,3,nil,'2','sdf'] }

  it 'should return array of indexes [1, 4]' do
    expect(StockPicker.new(stocks).call).to eq([1, 4])
  end

  it 'should return false' do
    expect(StockPicker.new(empty_array).call).to be_falsey
  end

  it 'should return false' do
    expect(StockPicker.new(invalid_array).call).to be_falsey
  end
end
