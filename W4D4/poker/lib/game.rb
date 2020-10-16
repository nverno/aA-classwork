#!/usr/bin/env ruby
# frozen_string_literal: true
require_relative 'deck'
require_relative 'player'

class Game
  def initialize (n_players)
    @players = (0...n_players).map { |i| Player.new(i) }
    @deck = Deck.new
    @pot = 0
    @folded = []
  end

  def active_players
    @players.reject { |player| @folded.include? player }
  end

  def game_over?
    @players.length <= 1
  end

  def deal
    puts 'Dealing cards...'
    @players.length.times do |i|
      5.times do
        @players[i].add_card(@deck.draw)
      end

      puts @players[i]
    end
  end

  def betting_round
    pending = active_players
    bets = pending.zip([0] * pending.size).to_h
    to_call = 0

    until pending.empty?
      curr_player = pending.shift
      begin
        bet = curr_player.handle_betting
        case bet
        when :see
          bets[curr_player] = to_call
          puts "#{curr_player} has called #{to_call}"
          # retry if to_call > bets[curr_player]
        when :fold
          puts "#{curr_player.number} has folded"
          @folded << curr_player
        else
          raise "Unknown bet: #{bet}" unless bet.is_a?(Integer)
          to_call += bet
          puts "#{curr_player} has raised #{bet}"
          # active players now need to be bet again
          active_players.each do |player|
            next if player == curr_player || pending.include?(player)
            pending << player
          end
        end
      end
    end
    @pot = to_call
    puts "The pot is now #{@pot}"
  end
  
  def play
    deal
    betting_round
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new(3)
  game.play
end
