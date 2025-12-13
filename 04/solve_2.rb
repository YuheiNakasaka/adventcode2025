codes = File.readlines('04/input.txt').map(&:chomp)
# codes = File.readlines('04/sample.txt').map(&:chomp)

matrix = []
codes.each do |code|
  matrix << code.chars
end

def around_paper_count(matrix, i, j, h, w)
  cnt = 0
  [-1,0,1].each do |di|
    [-1,0,1].each do |dj|
      next unless i+di >= 0 && i+di < h && j+dj >= 0 && j+dj < w

      if matrix[i+di][j+dj] == '@'
        cnt += 1
      end
    end
  end
  cnt
end

w = matrix[0].size
h = matrix.size
removed_positions = Set.new

loop do
  current_removed_positions_count = removed_positions.size
  clone_matrix = matrix.map(&:dup)
  h.times do |i|
    w.times do |j|
      if matrix[i][j] == '@' && around_paper_count(clone_matrix, i, j, h, w) <= 4
        matrix[i][j] = '.'
        removed_positions.add([i, j])
      end
    end
  end

  break if removed_positions.size == current_removed_positions_count
end

puts removed_positions.size
