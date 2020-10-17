#!/usr/bin/env ruby
# frozen_string_literal: true

def windowed_max_range_slow(arr, window_size)
  range_max = nil
  (0..arr.size - window_size).each do |i|
    ary = arr[i, window_size]
    range = ary.max - ary.min
    range_max = range if !range_max || range_max < range
  end
  range_max
end

class Q
  def initialize
    @store = []
  end
  def enqueue(elem)
    @store << elem
  end
  def dequeue
    @store.shift
  end
  def peek
    @store[0]
  end
  def empty?
    @store.empty?
  end
  def size
    @store.size
  end
end

class Stack
  def initialize
    @store = []
  end
  def push(elem)
    @store << elem
  end
  def pop
    @store.pop
  end
  def peek
    @store[-1]
  end
  def empty?
    @store.empty?
  end
  def size
    @store.size
  end
end

# Queue data structure implemented with two stacks for constant time
# dequeuing
class StackQueue
  def initialize
    @back = Stack.new
    @front = Stack.new
  end
  def size
    @back.size + @front.size
  end
  def empty?
    @front.empty? && @back.empty?
  end
  def enqueue(elem)
    @back.push(elem)
  end
  def dequeue
    if @front.empty?
      @front.push(@back.pop) until @back.empty?
    end
    @front.pop
  end
end

# Stack w/ constant lookup for current max value in stack
class MinMaxStack
  def initialize
    @store = []
    @max = []
    @min = []
  end
  def peek
    @store[-1]
  end
  def push(elem)
    @max << (@max[-1] && elem < @max[-1] ? @max[-1] : elem)
    @min << (@min[-1] && elem > @min[-1] ? @min[-1] : elem)
    @store << elem
  end
  def pop
    @min.pop
    @max.pop
    @store.pop
  end
  def empty?
    @store.empty?
  end
  def size
    @store.size
  end
  def max
    @max[-1]
  end
  def min
    @min[-1]
  end
end

# Queue w/ constant time dequeue and lookup for current min/max
class MinMaxStackQueue
  def initialize
    @front = MinMaxStack.new
    @back = MinMaxStack.new
  end
  def size
    @front.size + @back.size
  end
  def empty?
    @front.empty? && @back.empty?
  end
  def peek
    @front[-1]
  end
  def enqueue(elem)
    @back.push(elem)
  end
  def dequeue
    if @front.empty?
      @front.push(@back.pop) until @back.empty?
    end
    @front.pop
  end
  def min
    if @back.empty?
      @front.min
    elsif @front.empty?
      @back.min
    else
      [@front.min, @back.min].min
    end
  end
  def max
    if @back.empty?
      @front.max
    elsif @front.empty?
      @back.max
    else
      [@front.max, @back.max].max
    end
  end
end

def windowed_max_range(arr, window_size)
  q = MinMaxStackQueue.new
  range_max = nil
  arr.each do |ele|
    # require 'byebug'; debugger
    q.enqueue(ele)
    q.dequeue if q.size > window_size
    range = q.max - q.min
    range_max = range if !range_max || range > range_max
  end
  range_max
end

if __FILE__ == $PROGRAM_NAME
  p windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
  p windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
  p windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
  p windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
end
