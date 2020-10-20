class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if !include?(key)
      resize! if count == num_buckets
      self[key.hash] << key
      @count += 1
    end
  end

  def include?(key)
    self[key.hash].include?(key)
    # return false unless @store.include?(key)
    # true
  end

  def remove(key)
    if include?(key)
      @count -= 1
      self[key.hash].delete(key)
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    i = num % num_buckets
    @store[i]
  end

  def num_buckets
    @store.length
  end

  def resize!
    n = num_buckets * 2
    res = Array.new(n) { Array.new }

    @store.each do |bucket|
      bucket.each do |ele|
        i = ele.hash % n
        res[i] << ele
      end
    end
    @store = res
    count
  end
end

# store = [[], [], [1,2,3], ...]
# key = 2
# key.hash 1o3u43984
# store[2] = [1,2,3]
# self[2.hash] => store[2]
# 
