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

a = [1, 2, 3]
p a.my_any? { |num| num > 1 } # => true
p a.my_any? { |num| num == 4 } # => false
p a.my_all? { |num| num > 1 } # => false
p a.my_all? { |num| num < 4 } # => true