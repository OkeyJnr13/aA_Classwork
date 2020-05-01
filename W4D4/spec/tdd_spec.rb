require "rspec"
require "tdd"

describe "#my_uniq" do
subject(:array) { array = [1, 2, 1, 3, 3] }
it "should remove the duplicate elements in an array" do
        expect(array.my_uniq).to eq([1,2,3])
    end

    # context "should not use Array#uniq" do 
    #     it "should not use #uniq" do 
    #         expect(array).to_not receive(:uniq)
    #         array.uniq
    #     end
    # end

end

describe "Array#two_sum" do
    it "should return the pairs of indexes of nums that sum to zero" do 
        array = [-1, 0, 2, -2, 1] 
        expect(array.two_sum).to eq([[0, 4], [2, 3]])
    end
end

describe "#my_transpose" do
    it "should flip the rows and the columns on a square-nested array" do
       arr = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
       expect(my_transpose(arr)).to eq([[0, 3, 6], [1, 4, 7], [2, 5, 8]])
    end
end

describe "#stock_picker" do
    it "should return most profitable days to buy and sell stocks" do
        days_arr = [10, 5, 3, 8, 2, 9, 11]
        expect(stock_picker(days_arr)).to eq([4, 6])
    end
end

