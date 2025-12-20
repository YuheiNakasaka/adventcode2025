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

g = {}
h.times do |hi|
  puts input[hi].join('')
  w.times do |wi|
    if input[hi][wi] == 'S'
      g[[hi, wi]] ||= []
      i = 1
      while hi + i < h
        if input[hi + i][wi] == '|'
          i += 1
        elsif input[hi + i][wi] == '^'
          g[[hi, wi]] << [hi + i, wi]
          break
        end
      end
    elsif input[hi][wi] == '^'
      [-1, 1].each do |di|
        next unless wi + di >= 0 && wi + di < w
        g[[hi, wi]] ||= []
        i = 0
        while hi + i < h
          if input[hi + i][wi + di] == '|'
            i += 1
          elsif input[hi + i][wi + di] == '^'
            g[[hi, wi]] << [hi + i, wi + di]
            break
          elsif input[hi + i][wi + di] == 'o'
            g[[hi, wi]] << [hi + i, wi + di]
            break
          end
        end
      end
    end
  end
end

def dfs(g, v, memo)
  if g[v].nil?
    return 1
  end
  if memo[v]
    return memo[v]
  end
  sum = 0
  g[v].each do |vi|
    sum += dfs(g, vi, memo)
  end
  memo[v] = sum
  return sum
end

# p dfs(g, [0, 7], {})
p dfs(g, [0, 70], {})
