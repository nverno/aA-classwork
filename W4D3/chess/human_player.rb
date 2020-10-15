require_relative 'cursor'

class HumanPlayer
  attr_reader :color

  def initialize(color, display)
    @color = color
    @display = display
  end

  def make_move
    start_pos = @display.render
    end_pos = @display.render
    [start_pos, end_pos]
  end
end
