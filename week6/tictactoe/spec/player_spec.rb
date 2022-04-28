#!/usr/bin/env ruby
$LOAD_PATH << './lib'


RSpec.describe Player do
  context "initialize" do
    subject(:valid_player){ described_class.new("Gia", 0) }
    subject(:invalid_player){ described_class.new("Gia", 2) }
    
    it "name must be set" do
      expect(valid_player.name).to eq("Gia")
    end

    it "index must be set" do
      expect(valid_player.index).to eq(0)
    end 

    it "should true if player is valid" do
      expect(valid_player.valid?).to be_truthy
    end

    it "should false if player is invalid" do
      expect(invalid_player.valid?).to be_falsey
    end

    13.times do
      it "should false for all strings with 1-2 characters length for name" do
        expect(described_class.new(Faker::String.random(length: rand(1..2)), 0).valid?).to be_falsey
      end
    end

    13.times do
      it "should false for all strings with 11+ characters length for name" do
        expect(described_class.new(Faker::String.random(length: rand(12..125)), 0).valid?).to be_falsey
      end
    end
  end

  context "#capitalize" do
    subject(:player){ described_class.new("gia", 0) }
    let(:cap_name) { "Gia" }

    it "should give capitelized name" do
      expect(player.name).to eq(cap_name)
    end
  end

  context "#add_point" do
    subject(:player){ described_class.new("gia", 0) }
    it "starting point should be 0" do
      expect(player.point).to eq(0)
    end

    it "point should increase by 1" do
      expect(player.add_point(1)).to eq(1)
    end
  end

  context "#add_move" do
    subject(:player){ described_class.new("gia", 0) }
    let(:empty_hash){ Hash.new }

    it "must have empty moves" do
      expect(player.moves).to eq(empty_hash)
    end

    it "should work adding new move" do
      player.add_move(0, 'a1')
      expect(player.moves.size).to eq(1)
      expect(player.moves[0]).to eq('a1')
    end
  end

end
