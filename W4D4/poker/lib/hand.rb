#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'card'

class Hand
  include Comparable
  def initialize
    @cards = []
  end

  def add_card(card)
    @cards << card
  end

  def to_s
    @cards.map(&:to_s).join(' ')
  end
end

if __FILE__ == $PROGRAM_NAME
  hand = Hand.new
  [
    Card.new(:club, 2),
    Card.new(:diamond, 2),
    Card.new(:heart, 2),
    Card.new(:spade, 2),
    Card.new(:spade, 0),
  ].each { |c| hand.add_card(c) }
  puts "Hand = #{hand}"
end
