require "rspec"
require "tower_of_hanoi"

describe TowerOfHanoi do
    subject(:towers) {TowerOfHanoi.new}   

    describe "#initialize" do
        it "should set @towers to an array of 3 empty subarrays" do
            expect(towers.size).to eq(3)            
        end

        it "should have @towers.first sorted" do
            expect(towers[0]).to eq([1, 2, 3, 4])
        end
    end 

    # describe "#render" do
    #     it "should display current towers" do 
    #         expect(towers.render).to eq("")
    #     end
    # end

    describe "#move" do
        it "should take in 2 number arguements" do
            expect { towers.move("arg1", "arg2") }.to raise_error(TypeError)
        end
    end

    # describe "#won?" do
    #     let(:game) {TowerOfHanoi.new}
    #     it "should return true if all towers are in the 3rd stack and sorted" do
    #         game.towers = [[], [], [1, 3, 2                                , 4]]
    #         expect(game.won?).to eq(true)
    #     end
    
    # end
end