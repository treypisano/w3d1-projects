class Array

    def my_each(&blk)

        i = 0

        while i < self.length
            blk.call(self[i])
            i += 1
        end
        self
    end

    def my_select(&blk)
        new_arr = []
        self.my_each do |ele|
            new_arr << ele if blk.call(ele)
        end
        return new_arr
    end

    def my_reject(&blk)
        self - self.my_select{|ele| ele if blk.call(ele)}
    end

    def my_any?(&blk)
        if self.my_select {|ele| blk.call(ele)}.length >= 1
            return true
        else
            return false
        end
    end

    def my_all?(&blk)
        if self.my_select {|ele| blk.call(ele)}.length == self.length
            return true
        else
            return false
        end
    end

    def my_flatten
        if !self.is_a?(Array)
            return [self]
        end
        flattened = []
        self.each do |ele|
            if ele.is_a?(Array)
                flattened += ele.my_flatten
            else 
                flattened << ele
            end
        end
        flattened
    end

    def my_zip(*args)
        new_arr = []
        self.each_with_index do |self_ele, i|
            new_sub_arr = []
            new_sub_arr << self_ele
            args.each do |arg|
                if i < arg.length 
                    new_sub_arr << arg[i]
                else
                    new_sub_arr << nil
                end
            end
            new_arr << new_sub_arr
        end
        new_arr
    end
end

# calls my_each twice on the array, printing all the numbers twice.
# return_value = [1, 2, 3].my_each do |num|
#     puts num
#    end.my_each do |num|
#     puts num
#    end
#    # => 1
#    #    2
#    #    3
#    #    1
#    #    2
#    #    3
   
#    p return_value  # => [1, 2, 3]

# a = [1, 2, 3]
# p a.my_select { |num| num > 1 } # => [2, 3]
# p a.my_select { |num| num == 4 } # => []
# a = [1, 2, 3]
# p a.my_reject { |num| num > 1 } # => [1]
# p a.my_reject { |num| num == 4 } # => [1, 2, 3]

# a = [1, 2, 3]
# p a.my_any? { |num| num > 1 } # => true
# p a.my_any? { |num| num == 4 } # => false
# p a.my_all? { |num| num > 1 } # => false
# p a.my_all? { |num| num < 4 } # => true

# p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

a = [ 4, 5, 6 ]
b = [ 7, 8, 9 ]
p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

c = [10, 11, 12]
d = [13, 14, 15]
p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]