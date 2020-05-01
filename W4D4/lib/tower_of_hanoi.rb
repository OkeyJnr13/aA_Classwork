class TowerOfHanoi
    attr_accessor :towers
    
    def initialize
        @towers = [[1, 2, 3, 4], [], []]
        # (1..4).each do |num|
        #     @towers[0] << num
        # end
    end

    def size
        @towers.length
    end

    def [](pos)
        @towers[pos]
    end

    def move(from, to)
        if !@towers[from].empty?
            start = @towers[from].shift
            @towers[to].unshift(start)
        else
            raise "That stack is empty"
        end 
    end

    def won?
        @towers[0].empty? && @towers[1].empty? && @towers[2] == [1, 2, 3, 4]

    end
end