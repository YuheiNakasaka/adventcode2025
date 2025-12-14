input = File.readlines('05/input.txt').map(&:chomp)
# input = File.readlines('05/sample.txt').map(&:chomp)

f = false
ranges = []
ids = []
input.each do |line|
  if f || line == ''
    ids << line.to_i
    f = true
  else
    ranges << line.split('-').map(&:to_i)
  end
end

ranges = ranges.sort_by {|min, max| min}
min = ranges[0][0]
max = ranges[0][1]
cnt = max - min + 1
ranges.shift
ranges.each do |left, right|
  if max < left
    cnt += right - left + 1
    max = right
  elsif left <= max && max < right
    cnt += right - max
    max = right
  end
end
puts cnt
