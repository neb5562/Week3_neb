#!/usr/bin/env ruby
$LOAD_PATH << './lib'


require 'customenumerable'


[1,2,3,4].my_each do |item| 
  puts item
end
