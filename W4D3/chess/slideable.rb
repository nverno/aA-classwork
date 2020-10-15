module Slideable
  DIRS = {
    horizontal: [[0, -1], [0, 1]],
    vertical: [[-1, 0], [1, 0]],
    diagonal: [[-1, -1], [-1, 1], [1, 1], [1, -1]]
  }
  
  def moves
    valid_moves = []
    dirs = move_dirs
    dirs.each do |dir|
      diffs = DIRS[dir]
      diffs.each do |diff|
        curr_pos = new_pos(@pos, diff)
        while @board.in_bounds?(curr_pos) && !my_piece?(curr_pos)
          valid_moves << curr_pos
          break if opponent_piece?(curr_pos)
          curr_pos = new_pos(curr_pos, diff)
        end
      end
    end
    valid_moves
  end

  def empty_space?(pos)
    @board[pos].is_a?(NullPiece)
  end

  def my_piece?(pos)
    piece = @board[pos]
    piece.is_a?(NullPiece) ? false : piece.color == @color
  end
  
  def opponent_piece?(pos)
    piece = @board[pos]
    piece.is_a?(NullPiece) ? false : piece.color != @color
  end

  def new_pos(pos, delta)
    [pos[0] + delta[0], pos[1] + delta[1]]
  end

  def move_dirs
    raise "#{self.class} must define 'move_dirs'"
  end
end
