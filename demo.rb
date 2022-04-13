#!/usr/bin/env ruby
$LOAD_PATH << './lib'

require 'substrings'

words_to_search = []

puts 'please enter sentence:'
sentence = gets.chomp
puts "please enter words: (to stop enter 'stop')"
loop do
  word = gets.chomp
  break if word == 'stop'

  words_to_search << word
end

print SubStrings.new(sentence, words_to_search).call
print "\n"
