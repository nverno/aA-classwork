class StaticArray
  attr_reader :store

  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    self.store[i]
  end

  def []=(i, val)
    validate!(i)
    self.store[i] = val
  end

  def length
    self.store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, self.store.length - 1)
  end
end

class DynamicArray
  include Enumerable
  attr_accessor :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    i = i % count if i < 0
    push(nil) while i >= capacity
    @store[i]
  end

  def []=(i, val)
    push(nil) while i >= capacity
    # @count = [@count, i + 1].max
    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    @store.store.include?(val)
  end

  def push(val)
    resize! if count == capacity
    @store[count] = val
    @count += 1
  end

  def unshift(val)
    resize! if count == capacity
    count.downto(1).each { |i| @store[i] = @store[i - 1] }
    @store[0] = val
    @count += 1
  end

  def pop
    return nil if @count.zero?

    @count -= 1
    res = @store[count]
    @store[count] = nil
    res
  end

  def shift
    return nil if @count.zero?

    @count -= 1
    res = @store[0]
    (0..count).each { |i| @store[i] = @store[i + 1] }
    @store[count] = nil
    res
  end

  def first
    self[0]
  end

  def last
    self[count - 1]
  end

  def each
    (0...count).each { |i| yield self[i] }
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    # return false if other.length != count

    (0...@store.length).each { |i| return false if @store[i] != other[i] }
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    sz = capacity * 2
    res = StaticArray.new(sz)
    (0...@store.length).each { |i| res[i] = self[i] }
    @store = res
  end
end
