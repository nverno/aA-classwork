#!/usr/bin/env ruby


class Display

  def initialize(board, cursor)
    @board = board
    @cursor = cursor
  end

  def render
    until @cursor.get_input
      curr_pos = @cursor.cursor_pos
      piece = @board[curr_pos]
      @board.selected = curr_pos
      system("clear")
      @board.print
    end
    @cursor.cursor_pos
  end
end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  cursor = Cursor.new([0, 0], board)
  display = Display.new(board, cursor)
  display.render
end
