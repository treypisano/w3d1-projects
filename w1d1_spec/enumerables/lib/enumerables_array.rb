def factors(num)
    (1..num).select {|i| num % i == 0}
end

def subwords(word,array)
    new_arr = []
    (0...word.length).each do |i1|
        (i1...word.length).each do |i2|
            substr = word[i1..i2]
            if array.include?(substr)
                new_arr << substr
            end
        end
    end
    return new_arr
end

def doubler(arr)
    arr.each_with_index do |ele, i|
        arr[i] = ele * 2
    end
    arr
end
class Array
    def bubble_sort!(&blk)
        sorted = false
        while !sorted
            sorted = true
            (0...self.length - 1).each do |i|
                if self[i] > self[i + 1]
                    self[i], self[i + 1] = self[i + 1], self[i]
                    sorted = false
                end
            end
        end
        self
    end
end

# a = [1, 2, 3, 4, 5]
# p a.shuffle.bubble_sort!
# p doubler([1,2,3])
# p subwords("batcabtarbrat", ["cat", "car"])
# p subwords("asdfcatqwer", ["cat", "car"])
# p factors(7)
# p factors(13)
# p factors(10)