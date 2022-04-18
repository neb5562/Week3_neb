#!/usr/bin/env ruby
$LOAD_PATH << './lib'

require 'bubblesort'

RSpec.describe BubbleSort do
  let(:bubblesort) { BubbleSort.new([4, 3, 78, 2, 0, 2]) }

  context BubbleSort do
    it "must have array" do
      expect(bubblesort.array).to eq([4, 3, 78, 2, 0, 2])
    end

    it "must return sorted array" do
      expect(bubblesort.call).to eq([0, 2, 2, 3, 4, 78])
    end
    
  end

  context BubbleSort do
    let(:bubblesort) { BubbleSort.new([1, '3', nil]) }
    it "must return only integers error" do
      expect(bubblesort.call).to match(/integers/)
    end
  end

  context BubbleSort do
    let(:bubblesort) { BubbleSort.new([]) }
    it "must return empty array error" do
      expect(bubblesort.call).to match(/must/)
    end
  end
end
