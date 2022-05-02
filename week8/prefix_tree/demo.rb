#!/usr/bin/env ruby
$LOAD_PATH << './lib'


require 'node'
require 'pp'

tree = Node.new(true)

tree.add("depeche")
tree.add("dep")
tree.add("gia")
tree.add("gialo")
tree.add("giala")
tree.add("hello")
tree.add("hell")
tree.add("lol")

# pp tree

pp tree.include? 'gia'
pp tree.include? 'dep'
pp tree.include? 'he'
pp tree.include? 'giale'


pp tree.find 'gialo'
pp tree.find 'gialoo' # not working
