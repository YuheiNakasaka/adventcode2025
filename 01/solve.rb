codes = File.readlines('01/input.txt').map(&:chomp)
# codes = File.readlines('01/sample.txt').map(&:chomp)

start = 50
goal = 0
cnt = 0
codes.each do |code|
  direction = code[0]
  move = code[1..].to_i
  direction == 'L' ? start = (start - move) % 100 : start = (start + move) % 100
  cnt += 1 if start == goal
end

puts cnt
