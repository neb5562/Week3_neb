#!/usr/bin/env ruby
$LOAD_PATH << './lib'


require 'customenumerable'

a = [ false, nil]

# p a.my_select
# p a.each
# puts a.select{ |a| a > 3}
# puts
# puts a.my_select{ |a| a > 3}
# p a.my_count(1)
# p a.count(1)

p a.my_none? 1,2,3,4 
