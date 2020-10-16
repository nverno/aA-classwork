require 'card'
require 'deck'

describe Card do 
  let(:card) {Card.new(:club, 7)}

  describe "#initialize" do 
    it "should set @suit" do 
      expect(card.instance_variable_get(:@suit)).to eq(:club)
    end
    it "should set @value" do 
      expect(card.instance_variable_get(:@value)).to eq(7)
    end
  end

  describe "#to_s" do 
    it "should return the card string" do 
      expect(card.to_s).to eq("7C")
    end
  end
end

describe Deck do
  let(:deck) { Deck.new }
  # let(:mock) = double("name", :method1 => false)

  describe "#initialize" do
    it "should set @deck" do 
      expect(deck.instance_variable_get(:@deck)).to be_an_instance_of(Array)
    end
  end

  describe "#draw" do 
    it "returns a card in the deck" do
      card = deck.draw
      expect(deck.deck.length). to eq(51)
      expect(card).to be_an_instance_of(Card)
    end
  end
end
