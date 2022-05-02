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
    have = have_in_childs(word)
    return nil if word.length == 0
      if have.empty?
        no_child_found(word)
      else
        child_found(have, word)
      end
  end

  def include?(word, is_word = false)
    str = ""
    size = word.chars.size
    obj = have_in_childs(word)[0]
    last = false
    until obj.nil? do
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
    include?(string, true)
  end

  def to_s
    @char
  end

  private

  def no_child_found(word)
    obj = Node.new
    obj.is_end = true if word.length == 1
    obj.char = word.to_s[0]
    obj.add(word.to_s[1..-1])
    @next << obj
  end

  def child_found(have, word)
    have.first.is_end = true if word.length == 1
    have.first.char = word[0]
    have.first.add(word.to_s[1..-1])
  end

  def have_in_childs(word)
    @next.select{ |item| item.to_s == word[0].to_s }
  end
end
