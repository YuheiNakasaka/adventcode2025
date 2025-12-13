ranges = File.read('02/input.txt').split(',')
# ranges = File.read('02/sample.txt').split(',')

invalid_nums = []
ranges.each do |range|
  first, last = range.split('-').map(&:to_i)
  (first..last).each do |num|
    digits = num.to_s.chars
    if digits.length.even?
      invalid = true
      i = digits.length / 2
      i.times do |j|
        if digits[i+j] != digits[j]
          invalid = false
          break
        end
      end
      invalid_nums << num if invalid
    end
  end
end

puts invalid_nums.sum
