class MaxIntSet

  attr_reader :max, :store

  def initialize(max)
    @max = max
    @store = Array.new(max + 1, false)
  end

  def insert(num)
    is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    is_valid?(num)
    @store[num] = false
  end

  def include?(num)
    is_valid?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    raise "Out of bounds" if num > @max || num < 0
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @num_buckets = num_buckets
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    bucket = self[num]
    if !bucket.include?(num)
      # require 'byebug'; debugger
      bucket << num
      return true 
    else 
      return false 
    end
  end

  def remove(num)
    bucket = self[num]
    bucket.delete(num)
  end

  def include?(num)
    if @store.any? { |ele| ele.include?(num) }
      return true
    else
      return false
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    i = num % @num_buckets
    @store[i]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if num_buckets <= count
    bucket = self[num]
    if !bucket.include?(num) 
      @count += 1
      bucket << num
      true
    else
      false 
    end
  end

  def remove(num)
    bucket = self[num]
    if bucket.include?(num)
      bucket.delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    i = num % num_buckets
    @store[i]
  end

  def num_buckets
    @store.length
  end

  def resize!
    n = 2 * num_buckets
    resize = Array.new(n) {Array.new}
    @store.each do |arr|
      arr.each do |ele|
        i = ele % n 
        resize[i] << ele
      end
    end

    @store = resize
  end
end
