input = File.readlines('03/input.txt')
# input = File.readlines('03/sample.txt')

ans = 0
input.each do |line|
  ten_level_index = -1
  ten_level = -1
  chars = line.chars.map(&:to_i)
  (chars.length - 2).times do |i|
    if chars[i] > ten_level
      ten_level_index = i
      ten_level = chars[i]
    end
  end

  one_level = -1
  (ten_level_index + 1).upto(chars.length - 1).each do |i|
    if chars[i] > one_level
      one_level = chars[i]
    end
  end

  puts "#{line}: #{ten_level}#{one_level}"
  ans += ten_level * 10 + one_level
end

puts ans
