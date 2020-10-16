#!/usr/bin/env ruby
# frozen_string_literal: true
require_relative 'polytree'

class KnightPathFinder

  # Valid moves for a knight from POS
  def self.valid_moves(pos)
    [[-2, -1], [-2, 1],
     [-1, -2], [-1, 2],
     [1, -2], [2, 1], [1, 2],
     [2, -1]].
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
  # Node([0, 0])
  #   |             |
  # Node([1, 2]) Node([2, 1])
  # 
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

  # def trace_path_back(target) # [0, 1]
  #   q = [target]
  #   q << q.first
  # end

  def find_path(pos)
    end_node = PolyTreeNode.new(pos)
    build_move_tree # @root_node

    path = [pos] #[[3,3],[2,1],[0, 0]]
    current_node = @root_node.dfs(pos)

    until current_node == @root_node
      next_node = current_node.parent
      path << next_node.value
      current_node = next_node
    end
    path.reverse
  end

end

if __FILE__ == $PROGRAM_NAME
  kpf = KnightPathFinder.new([0, 0])
  p kpf.find_path([2, 1]) # => [[0, 0], [2, 1]]
  p kpf.find_path([3, 3]) # => [[0, 0], [2, 1], [3, 3]]
  p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
  p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]
end
