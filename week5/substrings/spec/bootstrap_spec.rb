#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH << './lib'

require 'substrings'
require 'faker'

context SubStrings do
  let(:sentence) { "Howdy partner, sit down! How's it going?" }
  let(:match_words) do
    %w[below down go going horn how howdy it i low own part partner sit]
  end

  it 'should return matcheshash' do
    expect(SubStrings.new(sentence,
                          match_words).call).to eq({ 'down' => 1, 'go' => 1, 'going' => 1, 'how' => 2, 'howdy' => 1, 'it' => 2, 'i' => 3,
                                                     'own' => 1, 'part' => 1, 'partner' => 1, 'sit' => 1 })
  end
end

context SubStrings do
  let(:sentence) { 'below' }
  let(:match_words) do
    %w[below down go going horn how howdy it i low own part partner sit]
  end

  it 'should return matcheshash' do
    expect(SubStrings.new(sentence, match_words).call).to eq({ 'below' => 1, 'low' => 1 })
  end
end

context SubStrings do
  let(:sentence) { nil }
  let(:match_words) do
    %w[below down go going horn how howdy it i low own part partner sit]
  end

  it 'should return false' do
    expect(SubStrings.new(sentence, match_words).call).to be_falsey
  end
end

context SubStrings do
  let(:sentence) { nil }
  let(:match_words) { [] }

  it 'should return false' do
    expect(SubStrings.new(sentence, match_words).call).to be_falsey
  end
end
