class Integer
  # Integer#hash already implemented for you
end

class Array
  # [2, 3, 1] != [1, 2, 3]
  # [2, 1].hash == [1, 2].hash
  def hash # => 91191991
    hash = 0
    self.each.with_index do |ele, i|
      # 0010 << 1
      # 0100
      # 0011 >> 1
      # 0001 == 1 >> 0010 
      # 0101010
      # 1111000
      # 1010010
      hash += ele.hash << i
    end
    hash
  end
end

class String
  def hash
    hash = 0
    self.each_char.with_index do |char, i|
      hash += char.ord.hash << i
    end
    hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    #0
    sorted = self.to_a

    hash = 0
    sorted.each do |k, v|
      hash += k.hash ^ v.hash
    end
    hash
  end
end
