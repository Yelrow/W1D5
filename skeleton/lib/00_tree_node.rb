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
    return self if self.value == target
    self.children.each do |child|
      search_result = child.dfs(target)
      return search_result unless search_result.nil?
    end
    nil
  end

  def inspect
    "#<PolyTreeNode value:#{self.value}, children: #{self.children}"
  end

  def bfs(target)
    arr = [self]
    until arr.empty?
      el = arr.shift
      return el if el.value == target
      el.children.each do |child|
        arr.push(child)
      end
    end
    nil
  end

end
