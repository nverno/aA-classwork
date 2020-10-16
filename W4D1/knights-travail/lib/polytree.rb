# require "byebug"
class PolyTreeNode
  attr_reader :parent
  attr_accessor :children, :value
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    @parent.children.delete(self) unless @parent.nil?
    @parent = node
    @parent.children.push(self) unless @parent.nil? || @parent.children.include?(self)
  end

  def add_child(node)
    return if children.include?(node)

    children << node
    node.parent = self
  end

  def remove_child(node)
    raise "Node #{self.value} already contains Node #{node.value}" unless children.include?(node)

    children.delete(node)
    node.parent = nil
  end

  def dfs(target_value)
    return self if @value == target_value
    return nil if @children.empty?

    @children.each do |child|
      res = child.dfs(target_value)
      return res if res
    end
    nil
  end

  def bfs(value)
    q = [self]
    until q.empty?
      node = q.shift
      return node if node.value == value

      q.concat(node.children)
    end
    nil
  end
end
