module Enumerable
  ARGUMENT_ERROR_MESSAGE = "wrong number of arguments (given %s, expected 0..1)".freeze
  TYPEERROR_ERROR_MESSAGE = "%s is not a symbol nor a string".freeze
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

  def my_all?(*parameter)
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
    count == self.size
  end

  def my_any?(*parameter)
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
    count > 0
  end

  def my_inject(*parameter)
    if  parameter.count > 1
      raise ArgumentError.new(sprintf(ARGUMENT_ERROR_MESSAGE, parameter.count))
    end

    index = 0
    
    if block_given?
      # was not able to get correct
      # answer when there was no parameter called
      # as a starting point, for example (0){...}
      # my_inject(0){ |i,t| i+t } => 8
      # my_inject{ |i,t| i+t } => 6
      # so i assigned first element as starting point
      # and then removed first element from array and 
      # assisgned array to temporary Array
      unless parameter[0].nil?
        starting = parameter[0]
        temporary_array = self
      else
        starting = self[0]
        temporary_array = self.drop(1)
      end
      while index < temporary_array.size do
        starting = yield(temporary_array[index], starting) 
        index += 1
      end
    end
    # same here
    if !block_given? && [Symbol, String].include?(parameter[0].class)
      starting = self[0]
      temporary_array = self.drop(1)
      while index < temporary_array.size do
        starting = starting.send(parameter[0].to_s.to_sym, temporary_array[index])
        index += 1
      end
    end
    starting
  end

  def my_map
    index = 0
    to_return = []
    if block_given?
      while index < self.size do
      to_return << yield(self[index])
        index += 1
      end
      to_return
    else
      self.enum_for(:my_map)
    end
  end

end
