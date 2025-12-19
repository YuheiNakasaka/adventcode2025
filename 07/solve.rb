input = File.readlines('07/input.txt').map{|_| _.chomp.split('')}
# input = File.readlines('07/sample.txt').map{|_| _.chomp.split('')}

h = input.length
w = input[0].length

h.times do |hi|
  w.times do |wi|
    if input[hi][wi] == 'S'
      if hi + 1 < h
        input[hi + 1][wi] = '|'
      end
    elsif input[hi][wi] == '^'
      if hi - 1 >= 0 && input[hi-1][wi] == '|'
        if wi - 1 >= 0
          input[hi][wi - 1] = '|'
        end
        if wi + 1 < w
          input[hi][wi + 1] = '|'
        end
      end
    elsif input[hi][wi] == '.'
      if hi - 1 >= 0 && input[hi - 1][wi] == '|'
        input[hi][wi] = '|'
      end
    end
  end
end

ans = 0
h.times do |hi|
  w.times do |wi|
    if input[hi][wi] == '^' && hi - 1 >= 0 && input[hi - 1][wi] == '|'
      ans += 1
    end
  end
end

puts ans
