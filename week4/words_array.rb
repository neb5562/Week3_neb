class WordsArray
  def initialize(array)
    @words_array = array
  end

  def longest_word
    @words_array.sort_by{ |word| word.length }.last
  end

  def words_symbol_count
    @words_array.inject({}) do |hash, word|
      hash[word] = word.to_s.length
      hash
    end
  end
end


puts WordsArray.new(['Ruby', 'Python', 'Java', '.NET', 'HTML', 'JavaScript']).longest_word
puts WordsArray.new(['Ruby', 'Python', 'Java', '.NET', 'HTML', 'JavaScript']).words_symbol_count
