require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    b = bucket(key)
    if b.include?(key)
      b.update(key, val)
    else
      resize! if count == num_buckets
      @count += 1
      b.append(key, val)
    end
  end

  def get(key)
    b = bucket(key)
    b.get(key)
  end

  def delete(key)
    b = bucket(key)
    return unless b.include?(key)

    @count -= 1
    b.remove(key)
  end

  def each
    @store.each do |buck|
      buck.each { |node| yield [node.key, node.val] }
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    n = num_buckets * 2
    res = Array.new(n) { LinkedList.new }
    @store.each do |b|
      b.each do |node|
        i = node.key.hash % n
        res[i].append(node.key, node.val)
      end
    end
    @store = res
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
