#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'tile.rb'

class Board
  def self.create_grid(n=9, prob_mine=0.2)
    Array.new(n) { Array.new(n) { Tile.new(rand < prob_mine) } }
  end

  def initialize(size = 9)
    @size = size
    @grid = Board.create_grid
    @nearby_mines = compute_nearby_mines
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    tile = grid[x][y]
    tile.value = value
  end

  def solved?
    @grid.flatten.all? { |t| t.revealed? || t.mine? }
  end

  def each_neighbor(pos)
    x, y = pos
    [-1, 1, 0].repeated_permutation(2).to_a.select do |i, j|
      next if i.zero? && j.zero?

      x = pos[0] + i
      y = pos[1] + j
      yield [x, y] if x >= 0 && x < @size && y >= 0 && y < @size
    end
  end

  def neighbors(pos)
    res = []
    each_neighbor(pos) { |i,j| res << [i, j] }
    res
  end

  def compute_nearby_mines
    res = Array.new(@size) { Array.new(@size, 0) }
    (0...@size).each do |i|
      (0...@size).each do |j|
        res[i][j] = count_nearby_mines([i, j])
      end
    end
    res
  end

  def count_nearby_mines(pos)
    count = 0
    count += 1 if self[pos].mine?
    each_neighbor(pos) do |x, y|
      neb = @grid[x][y]
      count += 1 if neb.mine?
    end
    count
  end

  def render
    puts "  #{(0...@size).to_a.join(' ')}"
    grid.each_with_index do |row, i|
      puts "#{i} #{row.join(' ')}"
    end
    nil
  end

  # reveal POS and all of its adjacent neighbors that have no bordering mines
  def reveal(pos)
    tile = self[pos]
    tile.reveal
    return if tile.mine?

    each_neighbor(pos) do |x, y| 
      tile = grid[x][y]
      unless tile.revealed?
        tile.value = @nearby_mines[x][y]
        reveal([x, y]) if tile.value.zero?
      end
    end
  end

  private

  attr_reader :grid
end

board = Board.new
