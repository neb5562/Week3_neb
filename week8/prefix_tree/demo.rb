#!/usr/bin/env ruby
$LOAD_PATH << './lib'


require 'node'
require 'csv'
require 'csv_runner'
require 'pp'

tree = Node.new(true)

tree.add("depeche")
tree.add("dep")
tree.add("dep")
tree.add("gialo")
tree.add("giala")
tree.add("gialebo")
tree.add("hello")
tree.add("hell")
tree.add("lol")
tree.add("lool")
tree.add("loler")
tree.add("lob")
tree.add("homeworker")
tree.add("worker")
tree.add("house")
tree.add("home")
tree.add("work")
tree.add("rembo")
tree.add("rails")
tree.add("rail")
tree.add("raill")
tree.add("raib")
tree.add("rrail")
tree.add("riil")
tree.add("e")
tree.add("ebay")

# checking if include?
puts "\nchecking inclues\n"

puts tree.include? 'gia'
puts tree.include? 'dep'
puts tree.include? 'he'
puts tree.include? 'be'
puts tree.include? 'giale'
puts tree.include? 'neb'
puts tree.include? 'ler'

# checking if word
puts "\nchecking finds\n"

puts tree.find 'gialo'
puts tree.find 'ab'
puts tree.find 'gialoo'

# delete
puts "\nexecuting deletes\n"

tree.delete("loler")
tree.delete("rail")
tree.delete("e")
tree.delete("dsf")

# full list
puts "\nfull list\n"

data = tree.list("")
puts data
# list words by prefix
# puts "\nby prefix\n"

# data2 = tree.list("gia")

# CsvRunner.save_to_file(data2)

# obj = CsvRunner.load_from_file('data.csv')



