module RandNumHelper
  def self.non_repdigit_number
    left = rand(1..5)
    right = rand(5..9)
    middle = rand(99..9999)

    (left.to_s + right.to_s + middle.to_s).to_i
  end
end
