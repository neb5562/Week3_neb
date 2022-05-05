#!/usr/bin/env ruby
$LOAD_PATH << './lib'


require 'node'
require 'csv' # in progress
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
puts
puts "checking inclues"
puts
puts tree.include? 'gia'
puts tree.include? 'dep'
puts tree.include? 'he'
puts tree.include? 'be'
puts tree.include? 'giale'
puts tree.include? 'neb'

# checking if word
puts
puts "checking finds"
puts
puts tree.find 'gialo'
puts tree.find 'ab'
puts tree.find 'gialoo'

# delete
puts
puts "executing deletes"
puts
tree.delete("loler")
tree.delete("rail")
tree.delete("e")

# full list
puts
puts "full list"
puts
tree.list("")

# list words by prefix
puts
puts "by prefix"
puts
tree.list("gia")
