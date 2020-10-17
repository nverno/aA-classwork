#!/usr/bin/env ruby
# frozen_string_literal: true

def two_sum?(arr, target_sum)
   arr.combination(2) { |x, y| return true if x + y == target_sum } 
   false
end



#time complexity: O(n^2)

def okay_two_sum?(arr, target)
    sorted = arr.sort 
    sorted.each do |ele|
        diff = target - ele
        next if diff == ele
        # [false, false, true, true, ...]
        return true if sorted.bsearch { |x| x >= diff } == diff
    end
    false
end

def two_sum?(arr, target)
    require 'set'
    # hash = Set.new (arr) # O(n)
    hash = arr.each_with_object(Hash.new(0)).each do |ele, h|
        h[ele] += 1
    end
    arr.each.with_index do |ele, i|    # O(n)
        diff = target - ele
        # hash.include? => O(1)
        next if diff == ele && hash[ele] == 1
        return true if hash.include?(diff)
    end
    false
end

arr = [0, 1, 5, 7]
p two_sum?(arr, 6) # => should be true
p two_sum?(arr, 10) # => should be false
