#!/usr/bin/env ruby
$LOAD_PATH << './lib'

require 'caesar'
require 'faker'

describe Caesar do
  let(:unencrypted_text) { "What a string!" }
  let(:shift_number) { 5 }
  # generates valid arrays of 9 numbers
  it "must return 'Bmfy f xywnsl!'" do
    expect(Caesar.new(unencrypted_text, shift_number).call).to eq("Bmfy f xywnsl!")
  end
end
