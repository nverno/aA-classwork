require_relative 'hand'

# A poker player
class Player
  attr_reader :number
  def initialize(number)
    @number = number
    @hand = Hand.new
  end

  def to_s
    "Player #{@number} (#{@hand})"
  end

  def add_card(card)
    @hand.add_card(card)
  end

  def discard?
    puts "Player #{@number}, How many cards to draw?"
    Integer(gets.chomp)
  end

  # fold, see, or raise
  def handle_betting
    puts "Player #{@number}, See, fold, or raise?"

    case (resp = gets.chomp)
    when /see/i
      :see
    when /fold/i
      :fold
    when /raise/i
      Integer(resp.split(' ')[1])
    else
      raise "Unknown player response: #{resp}"
    end
  end
end
