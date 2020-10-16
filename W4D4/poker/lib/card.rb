#!/usr/bin/env ruby
# frozen_string_literal: true

# suit and value instance variables 
# cards number 2 - 10 ... face cards 11, 12, 13
# ace 

class Card 
  FACE_CARDS = %w[J Q K].freeze
  attr_reader :suit, :value
  
  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def to_s
    value_s + suit_s
  end

  def value_s
    case value
    when 0
      'A'
    when 10..12
      FACE_CARDS[value - 10]
    else
      (value + 1).to_s
    end
  end

  def suit_s
    case suit
    when :club
      'C'
    when :heart
      'H'
    when :spade
      'S'
    when :diamond
      'D'
    else
      raise "Unknown cards suit: #{suit.to_s}"
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  puts Card.new(:club, 7).to_s
end
