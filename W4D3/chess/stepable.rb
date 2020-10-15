module Stepable
  def moves
    valid_moves = []
    move_diffs.each do |diff|
      pos = new_pos(diff)
      valid_moves << pos if empty_space?(pos) || opponent_piece?(pos)
    end
    valid_moves
  end

  def empty_space?(pos)
    @board[pos].is_a?(NullPiece)
  end

  def my_piece?(pos)
    piece = @board[pos]
    piece.is_a?(NullPiece) || piece.nil? ? false : piece.color == @color
  end
  
  def opponent_piece?(pos)
    piece = @board[pos]
    piece.is_a?(NullPiece) || piece.nil? ? false : piece.color != @color
  end

  def move_diffs
    raise "Must implement move_diffs on #{self.class}"
  end

  def new_pos(delta)
    [@pos[0] + delta[0], @pos[1] + delta[1]]
  end
end

