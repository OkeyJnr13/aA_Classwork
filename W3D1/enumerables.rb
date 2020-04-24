class Array 

    def my_each(&prc)
        i = 0 

        while i < self.length 
            prc.call(self[i])
            i += 1
        end 
        self 
    end 

    def my_select(&prc)
        results = [] 
        self.my_each { |el| results << el if prc.call(el)}
        results
    end 

    def my_reject(&prc)
        results = [] 
        self.my_each { |el| results << el if !prc.call(el)}
        results
    end 

    def my_any?(&prc)
        self.my_each {|el| return true if prc.call(el)}
        false
    end 

    def my_all?(&prc)
        self.my_each {|el| return false if !prc.call(el)}
        true
    end 

    def my_flatten
        results = []

        self.each do |el|
            if el.class != Array 
                results << el 
            else 
                results += el.my_flatten
            end
        end 

        results 
    end

    def my_zip(*args)
        results = []
        self.length.times do |idx|
            sub_array = [self[idx]]
            args.each do |arr|
                sub_array << arr[idx]
            end
            results << sub_array
        end
        results
    end

    def my_rotate(num = 1)
        arr = self.dup
        if num > 0
            num.times do
                ele = arr.shift
                arr << ele
            end
        else
            (-num).times do
                ele = arr.pop
                arr.unshift(ele)
            end 
        end
        arr
        # OR
        # new_num = num % self.length
        # self.drop(new_num) + self.take(new_num)
    end
    
    def my_join(args = '')
        results = self.first
        (1...self.length).each do |idx|
            results += args + self[idx] 
        end 
        results
    end 

    def my_reverse
        results = []
        i = self.length - 1 
        while i >= 0 
            results << self[i]
            i -= 1 
        end 
        results
    end 
end 

# p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
# p [ 1 ].my_reverse               #=> [1]


