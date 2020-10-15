#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "human_player"
require_relative "board"
require_relative 'cursor'
require_relative 'display'

class Game
  def initialize
    @board = Board.new
    cursor = Cursor.new([0, 0], @board)
    display = Display.new(@board, cursor)
    @players = [HumanPlayer.new(:B, display), HumanPlayer.new(:W, display)]
    @curr_player = @players.first
  end

  def switch_turns
    @curr_player = @players.rotate!.first
  end

  def play
    @board.print
    loop do
      begin
        move = @curr_player.make_move
        @board.move_piece(move[0], move[1])
        system("clear")
        @board.print
      rescue StandardError => err
        puts err
        puts "Try another move"
        retry
      end
      @board.in_check?(@curr_player.color)
      switch_turns
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end
