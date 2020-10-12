require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board # Array.new(3) { Array.new(3) }
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def children
    # empty_board_node = Array.new(9)
    res = []
    (0...3).each do |i|
      (0...3).each do |j|
        pos = [i, j]
        if @board.empty?(pos)
          real_next_mover_mark = @next_mover_mark == :x ? :o : :x
          current_state = @board.dup
          current_state[pos] = @next_mover_mark
          
          res << TicTacToeNode.new(current_state, real_next_mover_mark, pos)
        end
      end
    end
    res
  end 

  # def copy_board(board)
  #   res = Board.new
  #   board.rows.each_with_index do |row1, i|
  #     row1.each_with_index do |ele, j|
  #       res[i][j] = ele
  #     end 
  #   end 
  #   res
  # end


  def losing_node?(evaluator) #mark
    # other_mark = @next_mover_mark == evaluator ? 
    if @board.over? 
      winner = @board.winner
      return winner && winner != evaluator
    else 
      if evaluator == @next_mover_mark
        children.all?{|ele| ele.losing_node?(evaluator)}
      else 
        children.any?{|ele| ele.losing_node?(evaluator)}
      end 
    end 

  end

  def winning_node?(evaluator)
    
    if @board.over? 
      winner = @board.winner
      
      return winner && winner == evaluator
    else 
      if evaluator == @next_mover_mark
        children.any?{|ele| ele.winning_node?(evaluator)}
      else 
        # children.any?{|ele| ele.winning_node?(evaluator)}
        children.all?{|ele| ele.winning_node?(evaluator)}
      end 
    end 
  end
end
