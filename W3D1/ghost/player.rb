require "game"

class Player

    attr_reader :name 

    def initialize(name)
        @name = name  
    end

    def guess
        user_input = gets.chomp
    end 

    def alert_invalid_guess(guess)
        self.guess.valid_play?(guess)
    end 
    
end