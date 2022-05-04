#!/usr/bin/env ruby
$LOAD_PATH << './lib'


require 'node'
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

tree.add("homeworker")
tree.add("worker")
tree.add("house")
tree.add("home")
tree.add("work")
tree.add("rembo")
tree.add("rails")
tree.add("e")
# pp tree.include? 'gia'
# pp tree.include? 'dep'
# pp tree.include? 'he'
# pp tree.include? 'be'
# pp tree.include? 'giale'
# pp tree.include? 'neb'

# pp tree.find 'gialo'
# pp tree.find 'ab'
# pp tree.find 'gialoo'

# make demo interactive. let user choose which function to call.

puts "enter word for list:(press enter to get all list items)"
word = gets.chomp
tree.list(word)
