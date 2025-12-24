# input = File.readlines('09/sample.txt').map{|_| _.chomp.split(',').map(&:to_i)}
input = File.readlines('09/input.txt').map{|_| _.chomp.split(',').map(&:to_i)}

ans = -1
n = input.length
n.times do |i|
  n.times do |j|
    next if i == j
    ans = [ans, ((input[i][0] - input[j][0]).abs + 1) * ((input[i][1] - input[j][1]).abs + 1)].max
  end
end
puts ans
