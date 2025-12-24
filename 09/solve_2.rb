input = File.readlines('09/sample.txt').map{|_| _.chomp.split(',').map(&:to_i)}
# input = File.readlines('09/input.txt').map{|_| _.chomp.split(',').map(&:to_i)}

# p(px, py)とq(qx, qy)のp'(px, qy)とq'(qx, py)が領域内に存在する場合はvalidと考えて良いはず

g = {}
n = input.length
n.times do |i|
  n.times do |j|
    next if i == j
    if input[i][0] == input[j][0]
      g[input[i]] ||= {x: [], y: []}
      g[input[i]][:x] << input[j]
    elsif input[i][1] == input[j][1]
      g[input[i]] ||= {x: [], y: []}
      g[input[i]][:y] << input[j]
    end
  end
end

ans = -1
n.times do |i|
  n.times do |j|
    next if i == j
    same_x = g[input[i]][:x] && g[input[j]][:x]
    same_y = g[input[i]][:y] && g[input[j]][:y]

    if same_x && same_y
      ans = [ans, ((input[i][0] - input[j][0]).abs + 1) * ((input[i][1] - input[j][1]).abs + 1)].max
    end
  end
end

puts ans
