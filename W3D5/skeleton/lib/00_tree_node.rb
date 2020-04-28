class PolyTreeNode
    attr_reader :value, :parent, :children
    attr_accessor :children

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(node) #self's parent is node pass in 
        @parent.children.delete(self) if !self.parent.nil? #if self has a parent, delete before reassign new parent node
        if node.nil? #if this node does not exist
            @parent = nil 
        else
            @parent = node #@parent is self or self.parent (can't use bc in method)
            node.children << self if !node.children.include?(self)
        end
    end

    def add_child(node) #add node to self's children, self become node's parents
        node.parent = self 
    end

    def remove_child(node)
        raise "node is not one of my children" if !self.children.include?(node)
        self.children.delete(node)
        node.parent = nil 
    end

    def dfs(val)
        return self if self.value == val
        searching_arr = self.children 
        searching_arr.each do |node| 
            result = node.dfs(val)
            return result if !result.nil?
        end
        nil
    end

    def bfs(val) 
        return self if self.value == val 
        children_arr = self.children   

        while !children_arr.empty?
            children_arr.each do |child|
                return child if child.value == val
                child.children.each {|el| children_arr << el }
            end
            children_arr.shift
        end
        nil 
    end

end