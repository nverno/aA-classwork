# coding: utf-8

require_relative 'stepable'
require_relative 'slideable'
require 'singleton'

# Chess pieces
class Piece
  attr_reader :color
  attr_accessor :selected, :pos

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  def to_s
    raise 'Subpieces must implement to_s'
  end

  def dup
    case self
    when Rook
      Rook.new(@color, @board, @pos)
    when Pawn
      Pawn.new(@color, @board, @pos)
    when Queen
      Queen.new(@color, @board, @pos)
    when King
      King.new(@color, @board, @pos)
    when Bishop
      Bishop.new(@color, @board, @pos)
    when Knight
      Knight.new(@color, @board, @pos)
    end
  end

  def empty?
    is_a?(NullPiece)
  end

  def valid_moves
    moves
    # moves.reject { |move| self.move_into_check?(move) }
  end

  def valid_move?(pos)
    valid_moves.include?(pos)
  end

  # private
  def move_into_check?(end_pos)
    b = @board.dup
    b.move_piece(@pos, end_pos)
    b.in_check?(@color)
  end
end

# An empty placeholder
class NullPiece < Piece
  include Singleton
  def initialize
    super(nil, nil, nil)
  end

  def to_s
    '_'
  end
end

class Rook < Piece
  include Slideable

  def move_dirs
    [:horizontal, :vertical]
  end

  def to_s
    @color == :B ? '♜' : '♖'
  end
end

class Bishop < Piece
  include Slideable

  def move_dirs
    [:diagonal]
  end

  def to_s
    @color == :B ? '♝' : '♗'
  end
end

class Queen < Piece
  include Slideable

  def move_dirs
    %I[diagonal horizontal vertical]
  end

  def to_s
    @color == :B ? '♛' : '♕'
  end
end

class King < Piece

  include Stepable
  
  def move_diffs
    [[0, -1], [0, 1], [-1, 0], [1, 0], [1, 1], [1, -1], [-1, 1], [-1, -1]]
  end

  def to_s
    @color == :B ? '♚' : '♔'
  end
end

class Knight < Piece
  include Stepable
  def move_diffs
    [[-2, 1], [-2, -1], [2, 1], [2, -1], [-1, -2], [1, -2], [-1, 2], [1, 2]]
  end

  def to_s
    @color == :B ? '♞' : '♘'
  end
end

class Pawn < Piece
  def moves
    dy = move_dirs
    res = []
    row, col = @pos 

    fwd = [row + dy, col]
    fwd_fwd = [row + dy + dy, col]

    if @board.in_bounds?(fwd) && @board[fwd].empty?
      res << fwd
      res << fwd_fwd if at_start_row? && @board.in_bounds?(fwd_fwd) && @board[fwd_fwd].empty?
    end

    diags = [[row + dy, col + 1], [row + dy, col - 1]]
    diags.each do |pos|
      next unless @board.in_bounds?(pos)

      res << pos if @board[pos].color && @board[pos].color != @color
    end 
    res
  end

  def at_start_row?
    @color == :W && @pos[0] == 6 || @color == :B && @pos[0] == 1
  end

  def move_dirs
    @color == :B ? 1 : -1
  end

  def to_s
    @color == :B ? '♟︎' : '♙'
  end
end
