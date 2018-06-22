require 'byebug'

class PolyTreeNode
  attr_reader :value

  def initialize(value = nil)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def parent=(parent_node)
    if parent_node.nil?
      @parent = nil
      return parent
    end

    unless parent_node.children.include?(self)
      parent_node.children << self
      unless @parent.nil?
        @parent.children.delete(self)
      end
    end
    @parent = parent_node
  end

  def children
    @children
  end

  def add_child(child_node)
    child_node.parent=(self)
  end

  def remove_child(child)
    #Case1: there is  no child
    child.parent=(nil)
    raise "Sorry no child" unless self.children.include?(child)
  end

  def dfs(target)
    debugger
    return self if self.value == target
    search_result = self
    self.children.each do |child|
      search_result = child.dfs(target)
      return search_result unless search_result.nil?
    end
    nil
  end

  def inspect
    "#<PolyTreeNode value:#{self.value}, children: #{self.children}"
  end

end


nodes = ('a'..'g').map { |value| PolyTreeNode.new(value) }

parent_index = 0
nodes.each_with_index do |child, index|
  next if index.zero?
  child.parent = nodes[parent_index]
  parent_index += 1 if index.even?
end
p nodes
