require "byebug"
require "set"

class Game
    array = ("a".."z").to_a
    # ALPHABETS = Set.new(array)    
    #OR
    ALPHABETS = array.to_set
    # debugger


    def initialize(player_1, player_2)
        words = File.readlines("dictionary.txt").map(&:chomp)
        @player_1 = player_1
        @player_2 = player_2
        @fragment = fragment
        @dictionary = words.to_set
        # @current_player = @player_1
    end

    def current_player
        @player_1
    end

    def previous_player
        @player_2
    end

    def next_player!
        if self.current_player == @player_1
            self.current_player = @player_2
            self.previous_player = @player_1
        else
            self.current_player = @player_1
            self.previous_player = @player_2
        end
    end
    
    def take_turn(player)
        puts "#{self.current_player} enter a letter"
        input = gets.chomp
        if self.valid_play?(input)
            @fragment << input 
        end
        # else 
        while !ALPHABET.inlcude?(input)
            puts "#{self.current_player} please enter a valid alphabet letter"
            input = gets.chomp
            self.take_turn(player)
        end 

        
    end

    def valid_play?(string)
        return false if !ALPHABET.inlcude?(string)

        @dictionary.any? {|word| word.start_with?(@fragment + string)}
        #current player loses 
    end

    def play_round
        input = self.take_turn(self.current_player)

    end 
end

# if $PROGRAM_NAME == __FILE__
#   game = GhostGame.new(
#     Player.new("Gizmo"), 
#     Player.new("Breakfast"), 
#     Player.new("Toby"),
#     Player.new("Leonardo")
#     )

#   game.run
# end

# g = Game.new("p1", "p2")