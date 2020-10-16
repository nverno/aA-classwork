require 'rspec'
require 'polytree'
require 'knights_path_finder'

describe KnightPathFinder do
  let(:kpf) { KnightPathFinder.new([0, 0]) }

  describe "new_move_positions" do
    it "should return valid moves" do
      expect(kpf.new_move_positions([0, 0])).to eq([[1, 2], [2, 1]])
    end
    it "should not return moves already considered" do
      moves = kpf.new_move_positions([0, 0])
      expect(kpf.new_move_positions([0, 0])).to eq([])
    end
  end
  describe "find_path" do
    it "should find correct paths to end positions" do
      expect(kpf.find_path([2, 1])).to eq([[0, 0], [2, 1]])
      expect(kpf.find_path([3, 3])).to eq([[0, 0], [2, 1], [3, 3]])
      # kpf = KnightPathFinder.new([0, 0])
      expect(kpf.find_path([7, 6])).to eq([[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]])
      expect(kpf.find_path([6, 2])).to eq([[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]])
    end
  end
end