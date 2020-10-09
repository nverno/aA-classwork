# Tile in minesweeper
class Tile
  attr_accessor :neighbors, :mine
  alias :mine? :mine

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
      'F'
    elsif @revealed
      '_'
    else
      @value ? @value.to_s : '*'
    end
  end
end
