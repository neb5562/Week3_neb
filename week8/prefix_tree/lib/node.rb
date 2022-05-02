#!/usr/bin/env ruby
$LOAD_PATH << '../lib'

class Node
  attr_accessor :char, :is_end, :next

  def initialize(root = false)
    @char = nil
    @is_end = false
    @next = []
    @is_root = root
  end
  
  def add(word)
    have = @next.select{ |item| item.to_s == word[0].to_s }
    # check if any next have char
    unless word.length == 0
      if have.empty?
        obj = Node.new
        obj.is_end = true if word.length == 1
        obj.char = word.to_s[0]
        obj.add(word.to_s[1..-1])
        @next << obj
      else
        have.first.is_end = true if word.length == 1
        have.first.char = word[0]
        have.first.add(word.to_s[1..-1])
      end
    end
  end

  def include?(word, is_word = false)
    str = ""
    size = word.chars.size
    obj = @next.select{ |item| item.to_s == word[0] }[0]
    last = false
    size.times do
      last = obj
      str += obj.to_s
      obj = obj.next[0]    
    end
    if is_word
    str == word && last.is_end == true
    else
      str == word
    end
  end

  def list

  end

  def delete

  end

  def find(string)
    include? string, true
  end

  def to_s
    @char
  end

end
