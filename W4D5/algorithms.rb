#!/usr/bin/env ruby

def my_min(arr) 
    #double loop to compare elements
    min = arr.first
    (0...arr.length).to_a.combination(2).each do |i, j|
        m = [arr[i], arr[j]].min 
        min = m if m < min
    end
    min
end



def my_min_two(arr)
    min = arr.first
    arr.each do |ele|
        min = ele if ele < min
    end
    min
end

# list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
# p my_min_two(list)  # =>  -5
#time complexity : O(n^2)

# def largest_contiguous_subsum(arr)
#     subs = []
#     arr.each.with_index do |ele1, i1|
#         arr.each.with_index do |ele2, i2|
#             subs << arr[i1..i2]
#         end
#     end
#     subs.map { |ele| ele.sum }.max
# end

def largest_contiguous_subsum(arr)
    return arr.max if arr.all? { |e| e < 0 }
    largest_sum = 0 # [..., i, ...]
    current_sum = 0 # [.]

    arr.each do |ele|
        current_sum += ele
        largest_sum = current_sum if largest_sum < current_sum
        current_sum = 0 if current_sum < 0
        # current_sum = [0, current_sum].max
    end
    largest_sum
end

list = [5, 3, -7]
p largest_contiguous_subsum(list) # => 8

list = [2, 3, -6, 7, -6, 7]
p largest_contiguous_subsum(list) # => 8 (from [7, -6, 7])

list = [-5, -1, -3]
p largest_contiguous_subsum(list) # => -1 (from [-1])

# c = 5 + -6 = -1, m = 8
# c = 8
# list = [2, 3, -6, 8, -9, 7, 5]