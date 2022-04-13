#!/usr/bin/env ruby
$LOAD_PATH << '../lib'

class AttributeError < StandardError; end
require 'validation'

class SubStrings
  include Validation
  def initialize(sentence, words = [])
    @sentence   = sentence
    @words      = words
    @final_hash = {}
  end

  def call
    validate
    substrings
  rescue AttributeError => e
    warn e
  end

  private

  def validate
    Validation.validate_presence(@sentence, 'sentence')
    empty_array_message = 'words array must not be empty!'
    Validation.validate_with_lambda(@words.empty? == false, empty_array_message)
  end

  def substrings
    @words.map do |to_match|
      match_count = @sentence.downcase.scan(/#{to_match.downcase}/).length
      @final_hash[to_match.to_s] = match_count if match_count.positive?
    end

    @final_hash
  end
end
