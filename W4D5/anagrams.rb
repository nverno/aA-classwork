#!/usr/bin/env ruby
# frozen_string_literal: true

def first_anagram?(a, b)
    subs = a.chars.permutation.map do |perm|
        perm.join
    end
    subs.include?(b)
end

def second_anagram?(a, b)
    c = b.split('')
    a.each_char do |char|
        i = c.find_index(char)
        # [ , ,x, ,] => [ , ,nil, ,] => []
        c.delete_at(i) unless i.nil?
    end

    c.empty?
end

def third_anagram?(a, b)
    a.chars.sort == b.chars.sort
end

def fourth_anagram?(a, b)
    a.chars.tally == b.chars.tally
end

# p first_anagram?("elvis", "lives")    #=> true
# p first_anagram?("gizmo", "sally")    #=> false

# p second_anagram?("elvis", "lives")    #=> true
# p second_anagram?("gizmo", "sally")    #=> false

p fourth_anagram?("elvis", "lives")    #=> true
p fourth_anagram?("gizmo", "sally")    #=> false

# p first_anagram?('a'*20, 'aaa')
# p second_anagram?('a'*20, 'aaa')
