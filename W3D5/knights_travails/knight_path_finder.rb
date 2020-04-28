require "byebug"
require "../skeleton/lib/00_tree_node.rb"

class KnightPathFinder
    attr_reader :considered_positions
    
    @@knight_moves = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2] [1, 2], [2, -1], [2, 1]]
    
    def self.valid_moves(pos) #[1,1] ######[-1,0], [-1,0] [1,-1] [0,1]
        array = [] 
        @@knight_moves.each do |sub_move|
            row = sub_move[0] + pos[0]
            col = sub_move[1] + pos[1]
            sub = [row, col]
            array << sub if (row <= 7 && row >= 0) && (col <= 7 && col >= 0)
        end
    
        array
    end

    def initialize(start_position)
        @root_node = PolyTreeNode.new(start_position)
        @considered_positions = []  #unique
    end

    def new_move_positions(pos) #4
        potential_arr = KnightPathFinder.valid_moves(pos) 
            
        potential_arr.each do |position|
            self.considered_positions << position if !self.considered_positions.include?(position)
        end
        self.considered_positions #[-1,0], [-1,0] [1,-1] [0,1]
    end

    def build_move_tree(pos)    #[1,1] #build a poly tree from one position
        build_arr = self.new_move_positions(pos) #potential moves

        while !build_arr.empty? #[-1, -2] = [0,2]
            build_arr.each do |position|
                if !self.considered_positions.include?(position)
                    child_pos = self.new_move_positions(position)
                    child_pos.each {|ele| build_arr << ele}
                    self.build_move_tree(position)
                end
            end
            build_arr.shift
        end
        nil  
    end
end