#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'piece'
require 'colorize'

# A Chess Board
class Board
  def self.populate_pieces(board)
    board.rows[0] = populate_row(board, 0, :B)
    board.rows[1].fill { |col| Pawn.new(:B, board, [1, col]) }
    board.rows[6].fill { |col| Pawn.new(:W, board, [6, col]) }
    board.rows[7] = populate_row(board, 7, :W)
    {
      B: board.rows[0] + board.rows[1],
      W: board.rows[6] + board.rows[7]
    }
  end

  def self.populate_row(board, row, color)
    [
      Rook.new(color, board, [row, 0]),
      Knight.new(color, board, [row, 1]),
      Bishop.new(color, board, [row, 2]),
      Queen.new(color, board, [row, 3]),
      King.new(color, board, [row, 4]),
      Bishop.new(color, board, [row, 5]),
      Knight.new(color, board, [row, 6]),
      Rook.new(color, board, [row, 7])
    ]
  end

  attr_reader :rows
  attr_accessor :selected

  def initialize
    @sentinel = NullPiece.instance
    @rows = Array.new(8) { Array.new(8, @sentinel) }
    @pieces = Board.populate_pieces(self)
    @selected = [0, 0]
  end

  def print
    puts
    @rows.each_with_index do |row, i|
      mapped = row.map.with_index do |ele, j|
        @selected == [i, j] ? ele.to_s.red : ele.to_s
      end
      puts mapped.join(' ')
    end
  end

  def move_piece(start_pos, end_pos)
    piece = self[start_pos]
    raise "Invalid piece: no piece at #{start_pos}" if piece.is_a?(NullPiece)
    raise "Invalid move: #{piece.class} from #{start_pos} to #{end_pos}" unless piece.valid_move?(end_pos)

    piece.pos = end_pos
    self[end_pos] = piece
    self[start_pos] = @sentinel
  end

  def in_bounds?(pos)
    x, y = pos
    x >= 0 && x < 8 && y >= 0 && y < 8
  end

  def [](pos)
    return nil unless in_bounds?(pos)

    x, y = pos
    @rows[x][y]
  end

  def []=(pos, val)
    x, y = pos
    @rows[x][y] = val
  end

  def dup
    res = Board.new
    @rows.each.with_index do |row, i|
      row.each.with_index do |piece, j|
        res[[i, j]] = piece.empty? ? piece : piece.dup
      end
    end
    res
  end

  def opposite_color(color)
    color == :B ? :W : :B
  end

  def in_check?(color)
    king = @pieces[color].find { |p| p.is_a?(King) }
    opponent_moves = []
    # note: unsure if valid_moves or moves
    @pieces[opposite_color(color)].each { |p| opponent_moves += p.valid_moves }
    if opponent_moves.include?(king.pos)
      puts "Player #{color} is in check!"
      true
    else
      false
    end
  end

  def checkmate?(color)
    if in_check?(color) && @pieces[color].all? { |p| p.valid_moves.empty? }
      puts "Checkmate! Player #{opposite_color(color)} wins!"
      true
    else
      false
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  board.print

  b2 = board.dup
  print 'Checking board.dup...'
  print b2.object_id != board.object_id, '..'
  puts (b2.rows.zip(board.rows).all? { |a, b| a.object_id != b.object_id })
  
  # get all non-pawn pieces
  # rook_0 = board[[0, 0]]
  # knight_0 = board[[0, 1]]
  # bishop_0 = board[[0, 2]]
  # queen = board[[0, 3]]
  # king = board[[0, 4]]
  # bishop_1 = board[[0, 5]]
  # knight_1 = board[[0, 6]]
  # rook_1 = board[[0, 7]]

  # get all pawn pieces
  # pawn_0 = board[[1, 0]]
  # pawn_1 = board[[1, 1]]
  # pawn_2 = board[[1, 2]]
  # pawn_3 = board[[1, 3]]
  # pawn_4 = board[[1, 4]]
  # pawn_5 = board[[1, 5]]
  # pawn_6 = board[[1, 6]]
  # pawn_7 = board[[1, 7]]

  ####

  # board.move_piece([6, 5], [4, 5])
  # board.move_piece([6, 4], [4, 4])
  # board.move_piece([6, 2], [5, 2])
  # board.move_piece([6, 6], [5, 6])
  # board.move_piece([7, 3], [4, 0])
  # board.move_piece([1, 3], [2, 3])
  
  # board.move_piece([7, 5], [4, 2])
  # board.move_piece([7, 5], [4, 2])
  



  # board.print

  # p board.in_check?(:B)
  # p board.checkmate?(:B)
end
