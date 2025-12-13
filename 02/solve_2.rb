ranges = File.read('02/input.txt').split(',')
# ranges = File.read('02/sample.txt').split(',')

invalid_nums = []
ranges.each do |range|
  # puts "--#{range}--"
  first, last = range.split('-').map(&:to_i)
  (first..last).each do |num|
    digits = num.to_s.chars
    half = digits.length / 2
    (1..half).each do |i|
      if digits.each_slice(i).map(&:itself).tally.keys.length == 1
        invalid_nums << num
        # puts num
        break
      end
    end
  end
end

puts invalid_nums.sum
