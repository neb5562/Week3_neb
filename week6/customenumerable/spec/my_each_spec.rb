#!/usr/bin/env ruby
$LOAD_PATH << './lib'

require 'customenumerable'

RSpec.describe Enumerable do
  let(:rand_from) {1}
  let(:rand_to) {9}
  let(:rand_to_second) {9999}
  100.times do
    context Enumerable do
      let(:array) { Array.new(rand(rand_from...rand_to)) { rand(rand_from...rand_to_second) } }

      it ".each and .my_each must return same result" do
        first_array  = []
        second_array = []

        array.each do |item|
          first_array << item
        end

        array.my_each do |item|
          second_array << item
        end

        expect(first_array).to eq(second_array)
      end
    end
  end
end
