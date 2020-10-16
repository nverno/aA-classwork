#!/usr/bin/env ruby
# frozen_string_literal: true
require_relative 'board'
require_relative 'tile'

class Minesweeper
  def initialize(size=9)
    @size = size
    @board = Board.new(size)
  end

  def run
    loop do
      unless play_turn
        board.render
        puts "BOOM! You're dead."
        return
      end
      break if @board.solved?
    end

    board.render
    puts "Congratulations, you win!"
  end

  def play_turn
    board.render
    pos = get_pos
    tile = board[pos]
    board.reveal(pos)
    return false if tile.mine?
    true
  end

  def get_pos
    pos = nil
    until pos && valid_pos?(pos)
      puts "Please enter a position on the board (e.g., '3,4')"
      print "> "

      begin
        pos = parse_pos(gets.chomp)
      rescue
        puts "Invalid position entered (did you use a comma?)"
        puts ""

        pos = nil
      end
    end
    pos
  end

  def parse_pos(string)
    string.split(",").map { |char| Integer(char) }
  end

  def valid_pos?(pos)
    pos.is_a?(Array) &&
      pos.length == 2 &&
      pos.all? { |x| x.between?(0, @size - 1) }
  end

  # def get_val
  #   val = nil
  #   until val && valid_val?(val)
  #     puts "Please enter a value between 1 and 9 (0 to clear the tile)"
  #     print "> "
  #     val = parse_val(gets.chomp)
  #   end
  #   val
  # end

  # def parse_val(string)
  #   Integer(string)
  # end

  # def valid_val?(val)
  #   true
  #   # val.is_a?(Integer) &&
  #   #   val.between?(0, @size)
  # end

  private
  attr_reader :board
end

ms = Minesweeper.new
ms.run
