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

  context "validate horizontal winning combinations" do
    let(:winnng_horizontal_line_1){ [[1, nil, nil], [1, nil, nil], [1, nil, nil]] }
    let(:winnng_horizontal_line_2){ [[nil, 1, nil], [nil, 1, nil], [nil, 1, nil]] }
    let(:winnng_horizontal_line_3){ [[nil, nil, 1], [nil, nil, 1], [nil, nil, 1]] }
    subject("board_one"){ described_class.new(winnng_horizontal_line_1) }
    subject("board_two"){ described_class.new(winnng_horizontal_line_2) }
    subject("board_three"){ described_class.new(winnng_horizontal_line_3) }

    it "should give winning top horizontal line" do
      expect(board_one.winner_line?).to eq(1)
    end

    it "should give winning middle horizontal line" do
      expect(board_two.winner_line?).to eq(1)
    end

    it "should give winning bottom horizontal line" do
      expect(board_three.winner_line?).to eq(1)
    end
  end

  context "validate vertical winning combinations" do
    let(:winnng_vertical_line_1){ [[1, nil, nil], [1, nil, nil], [1, nil, nil]] }
    let(:winnng_vertical_line_2){ [[nil, 0, nil], [nil, 0, nil], [nil, 0, nil]] }
    let(:winnng_vertical_line_3){ [[nil, nil, 1], [nil, nil, 1], [nil, nil, 1]] }
    subject("board_one"){ described_class.new(winnng_vertical_line_1) }
    subject("board_two"){ described_class.new(winnng_vertical_line_2) }
    subject("board_three"){ described_class.new(winnng_vertical_line_3) }

    it "should give winning first vertical line" do
      expect(board_one.winner_line?).to eq(1)
    end

    it "should give winning middle vertical line" do
      expect(board_two.winner_line?).to eq(0)
    end

    it "should give winning last vertical line" do
      expect(board_three.winner_line?).to eq(1)
    end
  end

  context "validate diagonal winning combinations" do
    let(:winnng_diagonal_line_1){ [[1, nil, nil], [nil, 1, nil], [nil, nil, 1]] }
    let(:winnng_diagonal_line_2){ [[nil, nil, 0], [nil, 0, nil], [0, nil, nil]] }
    subject("board_one"){ described_class.new(winnng_diagonal_line_1) }
    subject("board_two"){ described_class.new(winnng_diagonal_line_2) }

    it "should give winning left diagonal line" do
      expect(board_one.winner_line?).to eq(1)
    end

    it "should give winning right diagonal line" do
      expect(board_two.winner_line?).to eq(0)
    end
  end

  context "validate diagonal winning combinations" do
    let(:no_win_1){ [[1, 0, 1], 
                    [1, 0, 0], 
                    [0, 1, 1]] }

    subject("board_one"){ described_class.new(no_win_1) }

    it "not winning combination 1" do
      expect(board_one.winner_line?).to be_falsey
    end

  end

end
