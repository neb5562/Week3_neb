CHARACTER_BYTES_TO_INDEX = 96
VOWELS = "aeiou"

class Vowel
  def initialize
    @vowels_hash = {}
  end

  def fill
    VOWELS.each_char do |vowel|
      @vowels_hash[vowel] = vowel.bytes.join.to_i - CHARACTER_BYTES_TO_INDEX
    end
  end

  def get_vowels_hash
    @vowels_hash
  end
end

vowels = Vowel.new
vowels.fill
puts vowels.get_vowels_hash