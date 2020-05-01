module Enumerable # rubocop:disable Style/ModuleLength
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

  def my_all?(arg = nil) # rubocop:disable Style/MethodLength
    stat = true

    if arg
      if arg.class == Class
        my_each do |num|
          stat = num.is_a?(arg)
        end
      else
        my_each do |num|
          stat = num.to_s.match?(arg.to_s)
        end
      end

    elsif block_given?
      my_each do |num|
        stat = false unless yield num
      end
    else
      my_each do |num|
        bool = !num
        stat = !bool
      end
    end
    stat
  end

  def my_any?(arg = nil) # rubocop:disable Style/MethodLength
    stat = false

    if arg
      if arg.class == Class
        my_each do |num|
          stat = num.is_a?(arg)
        end
      else

        my_each do |num|
          stat = num.to_s.match?(arg.to_s)
        end
      end

    elsif block_given?
      my_each do |num|
        stat = true if yield num
      end
    else
      my_each do |num|
        bool = !num
        stat = !bool
      end
    end
    stat
  end

  def my_none?(arg = nil) # rubocop:disable Style/MethodLength
    stat = true

    if arg
      if arg.class == Class
        my_each do |num|
          stat = !num.is_a?(arg)
        end
      else
        my_each do |num|
          stat = !num.to_s.match?(arg.to_s)
        end
      end

    elsif block_given?
      my_each do |num|
        stat = false if yield num
      end
    else
      my_each do |num|
        stat = !num
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

  def my_inject(acc = 0, sign = nil)
    if acc.is_a?(Symbol)
      sign = acc
      acc = %i[+ -].include?(acc) ? 0 : 1
    end

    my_each do |num|
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

# arr = [4, 6, 3]

# p arr.my_all?{|num| num%2==0}
# p arr.my_count(7)

# p (1..4).map { |i| i*i }
# p arr.my_inject(0) { |sum, n| sum + n }
# p arr.my_each_with_index

# p arr.my_all?
# p arr.multiply_els
# prop = proc { |x| x * 2 }
# p arr.my_map(prop)
# p [1, 2, 3].my_all? #should return true
# p [1, 2, nil].my_all? #should return false
# p [1, false, nil].my_all? #should return false
p %w[dog door rod blade].my_all?(/d/) # should return true.
p %w[dog door rod blade].my_all?(/t/) # should return false.
