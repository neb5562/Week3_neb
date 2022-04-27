#!/usr/bin/env ruby
$LOAD_PATH << './lib'


RSpec.describe Board do
  context "#initialize" do
    let(:empty_board){ [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]] }

    it "should set board" do
      expect(described_class.new(empty_board).board).not_to eq(nil)
    end
  end

  context "#fill_board" do
    let(:empty_board){ [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]] }
    subject{ described_class.new (empty_board) }

    it "should add index in board array" do
      subject.fill_board([0, 2], 0)

      expect(subject.board[0][2]).to eq(0)
    end
  end

  it "#winner_line?"
  it "validate winning combinations"
  context "#full?" do
    let(:full_board){ [[1, 1, 0], [0, 0, 1], [1, 0, 1]] }
    let(:not_full_board){ [[1, 1, 0], [nil, 0, 1], [1, 0, 1]] }
    
    it "should check if board is empty or not" do
      expect(described_class.new(full_board).full?).to eq(true)
      expect(described_class.new(not_full_board).full?).to eq(false)
    end
  end

  context "#can_fill" do
    let(:empty_board){ [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]] }
    subject{ described_class.new(empty_board) }

    it "should give true result for all elements, when they are nil" do
      expect(subject.can_fill([0,0])).to be_truthy
      expect(subject.can_fill([1,0])).to be_truthy
      subject.fill_board([0, 2], 0)
      expect(subject.can_fill([0,2])).to be_falsey
    end
  end

  context "#reset" do
    let(:empty_board){ [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]] }
    subject{ described_class.new(empty_board) }

    it "should reset board to default" do
      subject.fill_board([0, 2], 0)
      subject.reset
      expect(subject.board).to eq([[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]])
    end
  end
end
