input = File.readlines('06/input.txt').map(&:chomp).map{|o| o.split(' ')}.transpose
# input = File.readlines('06/sample.txt').map(&:chomp).map{|o| o.split(' ')}.transpose

ans = 0
input.each do |row|
  nums = row[0..row.size-2]
  op = row.last
  ans += eval("#{nums.join(op)}")
end

puts ans
