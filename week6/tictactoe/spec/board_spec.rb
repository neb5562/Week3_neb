#!/usr/bin/env ruby
$LOAD_PATH << './lib'


RSpec.describe Board do
  it "#initialize"
  it "#fill_board"
  it "#winner_line?"
  it "validate winning combinations"
  it "#full?"
  it "#can_fill"
  it "#reset"
end
