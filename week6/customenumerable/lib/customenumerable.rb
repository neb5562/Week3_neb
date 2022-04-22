module Enumerable
  ARGUMENT_ERROR_MESSAGE = "wrong number of arguments (given %s, expected 0..1)".freeze
  def my_each
    index = 0
    if block_given?
      while index < self.size do
        yield(self[index])
        index += 1
      end
      self
    else
      self.enum_for(:my_each)
    end
    
  end

  def my_each_with_index
    to_return = []
    index = 0
    if block_given?
      while index < self.size do
        yield(self[index], index)
        index += 1
      end
      self
    else
      self.enum_for(:my_each_with_index)
    end 
  end

  def my_select
    index = 0
    to_return = []
    if block_given?
      while index < self.size do
      to_return << self[index] if yield(self[index])
        index += 1
      end
      to_return
    else
      self.enum_for(:my_select)
    end
  end

  def my_count(*parameter)
    if  parameter.count > 1
      raise ArgumentError.new(sprintf(ARGUMENT_ERROR_MESSAGE, parameter.count)) 
    end
    count = 0
    index = 0
    while index < self.size do
      if block_given?
        count += 1 if yield(self[index])
      elsif parameter.size == 1
        count += 1 if self[index] == parameter[0]
      else
        count = self.size
      end
      index += 1
    end
    count
  end

  def my_none?(*parameter)
    if  parameter.count > 1
      raise ArgumentError.new(sprintf(ARGUMENT_ERROR_MESSAGE, parameter.count))
    end
    count = 0
    index = 0
    while index < self.size do
      if block_given?
        count += 1 if yield(self[index])
      elsif parameter.size == 1
        case self[index]
        when parameter[0]
            count += 1
        end
      else
        count += 1 if self[index] || nil
      end
      index += 1
    end
    count == 0
  end
end
