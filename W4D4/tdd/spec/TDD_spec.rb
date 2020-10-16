require "TDD"

describe "TDD" do
  let(:arr) { [5,5,2,3,2,4] }

  describe "#my_uniq" do 
    it "return the array with no duplicate elements" do
      expect(arr.my_uniq).to match_array([5,2,3,4])
    end
  end

  describe "#two_sum" do 
    let(:no_pairs) { [1,2,3] }
    let(:pairs) { [-1, 0, 2, -2, 1] }
    it "returns no indices when no pairs sum to zero" do
      expect(no_pairs.two_sum).to be_empty
    end
    it "returns indices when pairs sum to zero" do
      expect(pairs.two_sum).to match_array([[0,4], [2,3]])
    end
  end

  describe "#my_transpose" do
    let(:rows) { [[0, 1, 2],
                  [3, 4, 5],
                  [6, 7, 8]] }
    it "returns a new array where columns are now rows" do
      expect(rows.my_transpose).to match_array( [[0, 3, 6], [1, 4, 7], [2, 5, 8]] )
    end
  end

  describe "#stock_picker" do
    let(:stock1) { [5, 10, 8, 20, 2] }
    let(:stock2) { [5, 5, 5, 5] }
    it "finds the correct indices when the lowest price comes up" do 
      expect(stock_picker(stock1)).to eq([0,3])
    end
    it "finds some indices when all prices are the same" do 
      expect((0..3).to_a.repeated_combination(2).to_a).to include(stock_picker(stock2))
    end
  end
end

describe Game do
  describe "#towers_of_hanoi" do
    let(:tower) { [[8,7,6,5,4,3,2,1], [], []] }
    let(:tower2) { [[8,7,6,5,4], [3,2,1], []] }
    subject(:game) { Game.new(tower) }

    describe "#initialize" do
      it "instantiates a game" do
        expect(game.tower).to eq([[8,7,6,5,4,3,2,1], [], []])
      end
    end

    describe "#valid_move?" do
      it "checks if a move is valid" do
        expect(game.valid_move?([0, 1])).to be_truthy
      end
      it "checks if a move is invalid" do
        game2 = Game.new(tower2)
        expect(game2.valid_move?([0, 1])).to be_falsy
      end
    end

    describe "#won?" do 
      context "game is not over" do 
        it "returns false" do 
          expect(game.won?).to be_falsy
        end
      end

      context "game is over" do
        it "returns true" do 
          game3 = Game.new(tower.reverse)
          expect(game3.won?).to be_truthy
        end
      end
      
    end

  end
end
