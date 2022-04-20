WORDS_ARRAY = %w[Ruby Python Java .NET HTML JavaScript].freeze
class WordsArray
  def initialize(array)
    @words_array = array
  end

  def longest_word
    @words_array.max_by(&:length)
  end

  def words_symbol_count
    @words_array.each_with_object({}) do |word, hash|
      hash[word] = word.to_s.length
    end
  end
end

puts WordsArray.new(WORDS_ARRAY).longest_word
puts WordsArray.new(WORDS_ARRAY).words_symbol_count

