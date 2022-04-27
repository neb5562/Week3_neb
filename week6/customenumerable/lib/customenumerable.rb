module Enumerable
  ARGUMENT_ERROR_MESSAGE = 'wrong number of arguments (given %s, expected 0..1)'
  TYPEERROR_ERROR_MESSAGE = '%s is not a symbol nor a string'
  def my_each
    index = 0
    if block_given?
      while index < size
        yield(self[index])
        index += 1
      end
      self
    else
      enum_for(:my_each)
    end
  end

  def my_each_with_index
    to_return = []
    index = 0
    if block_given?
      while index < size
        yield(self[index], index)
        index += 1
      end
      self
    else
      enum_for(:my_each_with_index)
    end
  end

  def my_select
    index = 0
    to_return = []
    if block_given?
      while index < size
        to_return << self[index] if yield(self[index])
        index += 1
      end
      to_return
    else
      enum_for(:my_select)
    end
  end

  def my_count(*parameter)
    raise ArgumentError, format(ARGUMENT_ERROR_MESSAGE, parameter.count) if parameter.count > 1

    count = 0
    index = 0
    while index < size
      if block_given?
        count += 1 if yield(self[index])
      elsif parameter.size == 1
        count += 1 if self[index] == parameter[0]
      else
        count = size
      end
      index += 1
    end
    count
  end

  def my_none?(*parameter)
    raise ArgumentError, format(ARGUMENT_ERROR_MESSAGE, parameter.count) if parameter.count > 1

    count = 0
    index = 0
    while index < size
      if block_given?
        count += 1 if yield(self[index])
      elsif parameter.size == 1
        case self[index]
        when parameter[0]
          count += 1
        end
      elsif self[index] || nil
        count += 1
      end
      index += 1
    end
    count.zero?
  end

  def my_all?(*parameter)
    raise ArgumentError, format(ARGUMENT_ERROR_MESSAGE, parameter.count) if parameter.count > 1

    count = 0
    index = 0
    while index < size
      if block_given?
        count += 1 if yield(self[index])
      elsif parameter.size == 1
        case self[index]
        when parameter[0]
          count += 1
        end
      elsif self[index] || nil
        count += 1
      end
      index += 1
    end
    count == size
  end

  def my_any?(*parameter)
    raise ArgumentError, format(ARGUMENT_ERROR_MESSAGE, parameter.count) if parameter.count > 1

    count = 0
    index = 0
    while index < size
      if block_given?
        count += 1 if yield(self[index])
      elsif parameter.size == 1
        case self[index]
        when parameter[0]
          count += 1
        end
      elsif self[index] || nil
        count += 1
      end
      index += 1
    end
    count.positive?
  end

  def my_inject(*parameter)
    raise ArgumentError, format(ARGUMENT_ERROR_MESSAGE, parameter.count) if parameter.count > 1

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
      # p.s i know i have nested if statement
      if parameter[0].nil?
        starting = self[0]
        temporary_array = drop(1)
      else
        starting = parameter[0]
        temporary_array = self
      end
      while index < temporary_array.size
        starting = yield(temporary_array[index], starting)
        index += 1
      end
    end
    # same here
    if !block_given? && [Symbol, String].include?(parameter[0].class)
      starting = self[0]
      temporary_array = drop(1)
      while index < temporary_array.size
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
      while index < size
        to_return << yield(self[index])
        index += 1
      end
      to_return
    else
      enum_for(:my_map)
    end
  end
end
