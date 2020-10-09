#!/usr/bin/env ruby
# frozen_string_literal: true
require_relative 'polytree'

class KnightPathFinder

  # Valid moves for a knight from POS
  def self.valid_moves(pos)
    [[-2, -1], [-2, 1],
     [-1, -2], [-1, 2],
     [1, -2], [1, 2],
     [2, -1], [2, 1]].
      map { |x, y| [pos[0] + x, pos[1] + y] }.
      select { |x, y| x >= 0 && y >= 0 && x < 8 && y < 8 }
  end

  def initialize(start)
    @root_node = PolyTreeNode.new(start)
    @considered_positions = [start]
  end

  def new_move_positions(pos)
    moves = KnightPathFinder.valid_moves(pos).
              reject { |loc| @considered_positions.include?(loc) }
    moves.each { |move| @considered_positions << move }
    moves
  end

  def each_move(pos)
    new_move_positions(pos).each { |move| yield move }
  end

  # Build tree using BFS
  def build_move_tree
    q = [@root_node]
    until q.empty?
      node = q.shift
      each_move(node.value) do |move| 
        child = PolyTreeNode.new(move)
        q << child
        node.add_child(child)
      end
    end
  end

  def find_path(pos)
  end

end

if __FILE__ == $PROGRAM_NAME
  kpf = KnightPathFinder.new([0, 0])
  kpf.find_path([2, 1]) # => [[0, 0], [2, 1]]
  kpf.find_path([3, 3]) # => [[0, 0], [2, 1], [3, 3]]
end
