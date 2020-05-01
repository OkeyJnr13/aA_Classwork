class Array
    def my_uniq
        new_hash = Hash.new(0)

        self.each do |el|
            new_hash[el] += 1
        end
        new_hash.keys
    end

    def two_sum
        pairs = []
        (0...self.length).each do |i|
            (i+1...self.length).each do |j|
                pairs << [i, j] if self[i] + self[j] == 0
            end
        end
        pairs
    end

end

def my_transpose(arr)
    result = Array.new(arr.length) {[]}
    arr.each do |row|
        (0...row.length).each do |i|
            result[i] << row[i]
        end
    end
    result
end

def stock_picker(arr)
    result = []
    range = 0
    (0...arr.length - 1).each do |idx|
        (idx + 1...arr.length).each do |jdx|
            if (arr[jdx] - arr[idx]) > range
                result << [idx, jdx] 
                range = arr[jdx] - arr[idx]
            end
        end
    end
    result.last
end

