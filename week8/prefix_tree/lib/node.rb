#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH << '../lib'

class Node
  attr_accessor :char, :is_end, :roots, :is_root
  attr_reader :count

  def initialize(root = false)
    @char = nil
    @is_end = false
    @roots = []
    @is_root = root
    @count = 1
    @tree = []
  end

  def add(word)
    validate_word(word)
    have = have_in_childs(word)
    return nil if word.length.zero?

    if have.empty?
      no_child_found(word)
    else
      child_found(have, word)
    end
  end

  def include?(word, is_word = false)
    str = ''
    obj = self
    last = false

    word.chars.each do |chr|
      return false if obj.nil?

      obj = obj.roots.select { |item| item.to_s == chr }.first
      str += obj.to_s
    end

    is_word ? (str == word && obj.is_end == true) : str == word
  end

  def list(word = '')
    where = word.empty? ? self : have_in_childs(word)[0]
    recursive_list(where, word)
    pp @tree.sort_by { |s| s.scan(/\d+/).first.to_i }
  end

  
  def delete(word)
    validate_before_delete(word) ? do_delete(word) : invalid_delete(word)
  end

  def find(string)
    include?(string, true)
  end

  def to_s
    @char
  end

  def increase_count
    @count += 1
  end

  private

  def validate_word(word)
    !word.empty?
  end

  def invalid_delete(word)
    puts "'#{word}' does not exist in tree"
  end

  def do_delete(word)
    last_obj = self
    last = word[-1]
    sum_of_childs = 0

    word.chars.each do |chr|
      break if last_obj.nil? 

      last_obj = last_obj.roots.select { |item| item.to_s == chr }.first
      sum_of_childs += last_obj.count
    end

    if sum_of_childs == word.length
      self.roots.delete_if{ |item| item.to_s == word[0] }
    else
      last_obj.is_end = false
    end
  end

  def validate_before_delete(word)
    find(word)
  end

  def recursive_list(obj, prefix = '', str = '')
    return false if obj.nil?

    if prefix.length.positive? && include?(prefix)
      obj = self
      prefix.chars.each do |chr|
        obj = obj.roots.select { |item| item.to_s == chr }.first
      end
      recursive_list(obj, '', prefix[0..-2])

      return false
    end
    str += obj.to_s || ''
    @tree << str if obj.is_end
    
    obj.roots.each do |child|
      recursive_list(child, prefix, str)
    end
  end

  def downcase_char(char)
    char.to_s.downcase
  end

  def no_child_found(word)
    obj = Node.new
    obj.is_end = true if word.length == 1
    obj.char = downcase_char(word[0])
    obj.add(word.to_s[1..-1])
    @roots << obj
  end

  def child_found(have, word)
    have.first.is_end = true if word.length == 1
    have.first.char = downcase_char(word[0])
    have.first.add(word.to_s[1..-1])
    have.first.increase_count
  end

  def have_in_childs(word)
    @roots.select { |item| item.to_s == downcase_char(word[0]) }
  end
end
