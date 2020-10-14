class Piece
    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
    end

    def to_s
        @color == :B ? '♟︎' : '♙'
    end

    def empty?
        
    end

    def valid_moves
        raise "Must implement valid_moves"
    end

    def pos=(val)
        
    end

    def symbol
        
    end

    private
    def move_into_check?(end_pos)
        
    end
end

require "singleton"

class NullPiece < Piece
    include Singleton
    
    def initialize(color = nil, board = nil, pos = nil)
        super(nil, nil, nil)
    end

    def to_s
        '_'
    end
end

# null_p = NullPiece.instance