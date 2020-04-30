module Enumerable
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

  def my_all?(arg = nil)
    stat = true

    if arg
      if arg.class == Class
        my_each do |num|
          stat = num.is_a?(arg)
        end
      else
        my_each do |num|
          stat = num == arg
        end
      end

    elsif block_given?
      my_each do |num|
        stat = false unless yield num
      end
    else
      return stat
    end
    stat
  end

  def my_any?(arg = nil)
    stat = false

    if arg
      if arg.class == Class
        my_each do |num|
          stat = num.is_a?(arg)
        end
      else
        my_each do |num|
          stat = num == arg
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

  def my_none?(arg = nil)
    stat = true

    if arg
      if arg.class == Class
        my_each do |num|
          stat = num.is_a?(arg)
        end
      else
        my_each do |num|
          stat = num != arg
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

  def my_count(counter = size)
    p_count = 0
    if block_given?
      my_each do |num|
        p_count += 1 if yield num
      end
      counter = p_count
    end
    counter
  end

  def my_inject(acc = 0)
    my_each do |num|
      acc = yield(acc, num)
    end
    acc
  end

  def multiply_els
    my_inject(1) do |acc, num|
      acc * num
    end
  end

  def my_map(prop = nil)
    new_arr = []
    return to_enum(:my_map) unless block_given?

    if prop
      my_each do |num|
        new_arr.push(prop.call(num))
      end

    else
      my_each do |num|
        new_arr.push(yield num)
      end
    end

    new_arr
  end
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
