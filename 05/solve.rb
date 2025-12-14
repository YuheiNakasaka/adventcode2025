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

p ranges
p ids

set = Set.new
ranges.each do |min, max|
  ids.each do |id|
    if id >= min && id <= max
      set.add(id)
    end
  end
end

puts set.size
