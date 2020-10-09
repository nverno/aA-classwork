require 'colorize'

# Tile in minesweeper
class Tile
  attr_accessor :neighbors, :mine, :value, :revealed
  alias :mine? :mine
  alias :revealed? :revealed
  def initialize(mine)
    @mine = mine
    @value = nil
    @revealed = false
    @flagged = false
  end

  def flag
    @flagged = true
  end

  def reveal
    @revealed = true
  end

  def to_s
    if @flagged
      'F'.colorize(:red)
    elsif @revealed
      @mine ? 'X'.colorize(:red) : '_'
    else
      @value ? @value.to_s : '*'.colorize(:blue)
    end
  end
end
