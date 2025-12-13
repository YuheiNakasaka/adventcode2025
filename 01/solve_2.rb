codes = File.readlines('01/input.txt').map(&:chomp)
# codes = File.readlines('01/sample.txt').map(&:chomp)
# codes = ['L150', 'L1', 'R1']

start = 50
zero_cnt = 0
codes.each do |code|
  direction = code[0]
  move = code[1..].to_i

  if direction == 'L'
    res = start - move
    if start != 0 && res <= 0
      zero_cnt += (res.abs / 100) + 1
    end
    if start == 0 && res <= -100
      zero_cnt += res.abs / 100
    end
    start = res % 100
    puts "code: #{code} start: #{start} zero_cnt: #{zero_cnt} res: #{res}"
  else
    res = start + move
    zero_cnt += res / 100
    start = res % 100
    puts "code: #{code} start: #{start} zero_cnt: #{zero_cnt} res: #{res}"
  end
end

puts zero_cnt
