class Array

  def my_uniq
    uniq
  end

  def two_sum
    res = []
    self.each_with_index do |num, i|
      self.each_with_index do |num2, j|
        if j > i
          if num + num2 == 0
            res << [i, j]
          end
        end
      end
    end
    res
  end

  def my_transpose
    res = []
    (0...length).each do |i|
      arr = []
      self.each do |subarray|
        arr << subarray[i]
      end
      res << arr
    end
    res
  end
end

def stock_picker(arr)
  stocks = [0,0]
  profit = 0
  (0...arr.length).to_a.combination(2) do |i, j|
    curr = arr[j] - arr[i]
    if curr > profit
      profit = curr
      stocks = [i,j]
    end
  end
  stocks
end

class Game
  attr_accessor :tower
  def initialize(tower)
    # [[....], [], []]
    @tower = tower
  end

  # [ index of start, index of end ]
  def valid_move?(move)
    from, to = move
    return false if tower[from].empty?
    return true if tower[to].empty?
    tower[from].last < tower[to].last
  end

  def won?
    tower[0].empty? && (tower[1].empty? || tower[2].empty?)
  end

  def render
    len = tower.map(&:length).max
    puts "0     1       2"
    (0...len).each do |row|
      puts tower.map{ |e| e[row].to_s }.join("\t")
    end
  end

  def play
    until won?
      render
      move = gets.chomp.split(",").map(&:to_i)
      if !valid_move?(move)
        puts "invalid move, choose another (one chance...)"
        move = gets.chomp.split(",").map(&:to_i)
      end
      from, to = move
      tower[to].push(tower[from].pop)
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new([[8,7,6,5,4,3,2,1], [], []])
  game.play
end
