module Enumerable # rubocop:disable Metrics/ModuleLength
  def my_each
    i = 0
    arr = to_a
    return to_enum(:my_each) unless block_given?

    while i < arr.size
      yield arr[i]
      i += 1
    end
    self
  end

  def my_each_with_index
    i = 0
    arr = to_a
    return to_enum(:my_each_with_index) unless block_given?

    while i < arr.size
      yield arr[i], i
      i += 1
    end

    self
  end

  def my_select
    new_arr = []
    return to_enum(:my_select) unless block_given?

    my_each do |num|
      new_arr.push(num) if yield num
    end

    new_arr
  end

  def my_all?(arg = nil) # rubocop:disable Metrics/MethodLength,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
    stat = true

    if arg
      if arg.class == Class
        my_each do |num|
          stat = num.is_a?(arg)
          return stat if stat ^ 0
        end
      else
        my_each do |num|
          stat = num.to_s.match?(arg.to_s)
          return stat if stat == false
        end
      end

    elsif block_given?
      my_each do |num|
        stat = false unless yield num
        return stat if stat == false
      end
    else
      my_each do |num|
        stat = num ^ 1
        return stat if stat == false
      end
    end
    stat
  end

  def my_any?(arg = nil) # rubocop:disable Metrics/MethodLength,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
    stat = false

    if arg
      if arg.class == Class
        my_each do |num|
          stat = num.is_a?(arg)
          return stat if stat == true
        end
      else

        my_each do |num|
          stat = num.to_s.match?(arg.to_s)
          return stat if stat == true
        end
      end

    elsif block_given?
      my_each do |num|
        stat = true if yield num
        return stat if stat == true
      end
    else
      my_each do |num|
        stat = num ^ 1
        return stat if stat == true
      end
    end
    stat
  end

  def my_none?(arg = nil) # rubocop:disable Metrics/MethodLength,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
    stat = true

    if arg
      if arg.class == Class
        my_each do |num|
          stat = !num.is_a?(arg)
          return stat if stat == false
        end
      else
        my_each do |num|
          stat = !num.to_s.match?(arg.to_s)
          return stat if stat == false
        end
      end

    elsif block_given?
      my_each do |num|
        stat = false if yield num
        return stat if stat == false
      end
    else
      my_each do |num|
        stat = !num
        return stat if stat == false
      end
    end
    stat
  end

  def my_count(counter = nil)
    p_count = 0
    return size if counter.nil? && !block_given?

    if block_given?
      my_each do |num|
        p_count += 1 if yield num
      end

    end
    my_each do |num|
      p_count += 1 if num == counter
    end
    p_count
  end

  def my_inject(acc = 0, sign = nil) # rubocop:disable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
    if acc.is_a?(Symbol)
      sign = acc
      acc = %i[+ -].include?(acc) ? 0 : 1
    end

    my_each do |num|
      acc = '' if num.class.eql?(String) && (acc.class.eql?(Integer) || acc.class.eql?(Float))
      acc = sign&.to_proc&.call(acc, num) if sign
      acc = yield acc, num if block_given?
    end

    acc
  end

  def my_map(prop = nil)
    return to_enum(:my_map) unless block_given?

    new_arr = []
    my_each do |num|
      new_arr.push(prop ? prop.call(num) : yield(num))
    end
    new_arr
  end
end

def multiply_els(array)
  array.my_inject { |acc, num| acc * num }
end
