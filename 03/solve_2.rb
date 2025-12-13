input = File.readlines('03/input.txt')
# input = File.readlines('03/sample.txt')

ans = 0
input.each do |line|
  digits = line.chomp.chars.map(&:to_i)
  candicates = []
  12.downto(1).each do |i|
    keta_kouho = Array.new(10) { Array.new }
    start_index = candicates.last ? candicates.last[1] + 1 : 0
    start_index.upto(digits.length - i).each do |j|
      keta_kouho[digits[j]] << [digits[j], j]
    end

    big_ketas = nil
    keta_kouho.reverse.each do |ketas|
      if ketas.length > 0
        big_ketas = ketas
        break
      end
    end

    candidate = big_ketas.sort_by {|keta| -keta[0]}.first
    candicates << candidate
  end

  ans += candicates.map {|candidate| "#{candidate[0]}"}.join.to_i
end

puts ans
# 987654321111111: 987654321111
# 811111111111119: 811111111119
# 234234234234278: 434234234278
# 818181911112111: 888911112111
# sum: 3121910778619
