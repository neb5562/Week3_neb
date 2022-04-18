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

      it ".select and .my_select must return same result" do
        first_array  = []
        second_array = []

        first_array = array.select{ |item| item > 120}

        second_array = array.select{ |item| item > 120}

        expect(first_array).to eq(second_array)
      end
    end
  end
end
