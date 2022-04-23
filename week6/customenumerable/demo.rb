#!/usr/bin/env ruby
$LOAD_PATH << './lib'


require 'customenumerable'

a = [ 2, 1, 2, 1, 3]
# p a.my_select{|x| x%2 == 0}
# p a.each
# puts a.select{ |a| a > 3}
# puts
# puts a.my_select{ |a| a > 3}
# p a.my_count(1)
# p a.count(&:even?)

# p a.my_all?(&:even?)
# p a.all?(&:even?)

# p a.my_inject(:a)
p a.my_inject(:*)
# p a.my_inject(&:sum)
p a.inject(:*)
# p a.inject (0) { |result_memo, object| result_memo + object }
