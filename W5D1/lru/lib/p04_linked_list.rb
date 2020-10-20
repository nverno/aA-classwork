class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new(:head)
    @tail = Node.new(:tail)
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    each { |link| return link.val if link.key == key }
  end

  def include?(key)
    each { |link| return true if link.key == key }
    false
  end

  def append(key, val)
    curr_tail = @tail.prev
    node = Node.new(key, val)
    node.next = @tail
    node.prev = curr_tail
    curr_tail.next = node
    @tail.prev = node
  end

  def update(key, val)
    each { |link| link.val = val if link.key == key }
  end

  def remove(key)
    each do |link|
      next unless link.key == key

      link.prev.next = link.next
      link.next.prev = link.prev
      break
    end
  end

  def each
    node = @head
    while (node = node.next) != @tail
      yield node
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
