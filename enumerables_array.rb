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

    # example 1 
    # a , orignial 1 = 0
    #a new_i = 3
    #new_i = 0 + (length - n)

    def my_rotate(n=1)
        new_arr = Array.new(self.length)
        
        self.each_with_index do |ele,i|
            new_i = i - n  % self.length
            new_arr[new_i] = ele
        end
        new_arr
    end

    def my_join(string="")
        new_str = ""
        self.each do |ele|
            new_str += ele
            new_str += string
        end
        new_str 
    end

    def my_reverse
        i = self.length - 1
        new_arr = []

        while i >= 0 
            new_arr << self[i]
            i -= 1
        end
        new_arr
    end
end

p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]

# a = [ "a", "b", "c", "d" ]
# p a.my_join         # => "abcd"
# p a.my_join("$")    # => "a$b$c$d"

# a = [ "a", "b", "c", "d" ]
# p a.my_rotate         #=> ["b", "c", "d", "a"]
# p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
# p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
# p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

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

# a = [ 4, 5, 6 ]
# b = [ 7, 8, 9 ]
# p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
# p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
# p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

# c = [10, 11, 12]
# d = [13, 14, 15]
# p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]