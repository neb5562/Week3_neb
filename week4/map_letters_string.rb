class AttributeError < StandardError; end
require './validation'
class MapString
  include Validation
  def initialize(word)
    @word = word
  end

  def call
    validate_word
    map_word
  rescue AttributeError => e
    warn e
  end

  private
  def validate_word
    Validation.validate_presence(@word, "word")
  end

  def map_word
    hash = {}
    @word.split("").each_with_index do |character, index|
      (hash[character] ||= []) << index
    end
    hash
  end
end

puts "please enter word:"
word = gets.chomp

puts MapString.new(word).call
