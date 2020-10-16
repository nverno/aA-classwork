#!/usr/bin/env ruby
# frozen_string_literal: true
require_relative 'card'

# A deck of playing cards
class Deck
  SUITS = %I[club diamond heart spade].freeze
  attr_accessor :deck
  def initialize
    @deck = fill_deck
  end

  def fill_deck
    res = []
    SUITS.each do |suit|
      (0...13).each { |i| res << Card.new(suit, i) }
    end
    res.shuffle
  end

  def draw
    @deck.pop
  end
end
