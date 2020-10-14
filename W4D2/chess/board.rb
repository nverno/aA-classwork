require_relative 'piece'

class Board
    def self.populate_pieces(board)
        board.rows[0].fill { |col| Piece.new(:W, board, [0, col]) }
        board.rows[1].fill { |col| Piece.new(:W, board, [1, col]) }
        board.rows[6].fill { |col| Piece.new(:B, board, [6, col]) }
        board.rows[7].fill { |col| Piece.new(:B, board, [7, col]) }
    end

    attr_reader :rows
    def initialize()
        @sentinel = NullPiece.instance
        @rows = Array.new(8) { Array.new(8, @sentinel) }
        Board.populate_pieces(self)
    end

    def print
        @rows.each do |row|
            puts "#{row.map(&:to_s).join(" ")}"
        end
    end

    def move_piece(start_pos, end_pos)
        piece = self[start_pos]
        raise "Invalid piece" if piece.is_a?(NullPiece)
        # raise "Invalid move" unless piece.valid_moves.include?(end_pos)
        raise "Space already occupied" unless self[end_pos].is_a?(NullPiece)
        self[end_pos] = piece
        self[start_pos] = @sentinel
    end

    def [](pos)
        x, y = pos
        @rows[x][y]
    end

    def []=(pos, val)
        x, y = pos
        @rows[x][y] = val
    end
end

board = Board.new
board.print
board.move_piece([1,0], [2,0])
board.print
board.move_piece([4,0], [6,0])
board.print
