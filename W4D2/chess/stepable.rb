module Stepable
    MOVES = {
        left: [0, -1],
        right: [0, 1],
        up: [-1, 0],
        down: [1, 0],
        upleft: [-1, -1],
        upright: [-1, 1],
        downleft: [1, -1],
        downright: [1, 1]
    }

    def moves
        case self.class
        when Knight
            moves = [[1, -2], [2, -1], [2, 1], [1, 2], [2, -1], [1, -2], [-2, -1]]
            moves.map do |x, y|
                [@pos[0] + x, @pos[1] + y]
            end
        when King
            valid_moves = []
            MOVES.keys.each do |dir|
                new_move = move(@pos, dir)
            end
        end
    end
    
    def move(pos, dir)
        [@pos[0] + MOVES[dir][0], @pos[1] + MOVES[dir][1]]
    end
end

# Knight:

# up, up, right
# up, up, left

# down, down, left
# down, down, right

# right, right, up
# right, right, down

# left, left, up
# left, left, down

# King:

# up
# down
# left
# right
# up, up
# down, down
# right, right
# left, left