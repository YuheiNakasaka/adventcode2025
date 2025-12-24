# frozen_string_literal: true

# ---------------------------
# 2D prefix sum helper
# ps is (h+1) x (w+1) flattened, width = w1 = w+1
# sum over inclusive cell-rectangle [r1..r2] x [c1..c2]
# ---------------------------
def rect_sum(ps, w1, r1, c1, r2, c2)
  return 0 if r1 > r2 || c1 > c2
  a = ps[r1 * w1 + c1]
  b = ps[r1 * w1 + (c2 + 1)]
  c = ps[(r2 + 1) * w1 + c1]
  d = ps[(r2 + 1) * w1 + (c2 + 1)]
  d - b - c + a
end

# ---------------------------
# Read input points (red tiles)
# ---------------------------
# pts = STDIN.read.lines.map(&:strip).reject(&:empty?).map do |line|
#   x_str, y_str = line.split(",")
#   [x_str.to_i, y_str.to_i]
# end
pts = File.readlines('09/sample.txt').map{|_| _.chomp.split(',').map(&:to_i)}
n = pts.length

if n < 2
  puts 0
  exit
end

# ---------------------------
# Step 1: Coordinate compression
# - include x and x+1 (same for y) so that boundary "rows/cols" become their own bands
# - add padding for outside flood fill
# ---------------------------
xs = []
ys = []

min_x = pts.map(&:first).min
max_x = pts.map(&:first).max
min_y = pts.map(&:last).min
max_y = pts.map(&:last).max

pts.each do |x, y|
  xs << x
  xs << x + 1
  ys << y
  ys << y + 1
end

# padding (a couple units is enough)
xs << (min_x - 2)
xs << (max_x + 3)
ys << (min_y - 2)
ys << (max_y + 3)

xs = xs.uniq.sort
ys = ys.uniq.sort

x_to_i = {}
xs.each_with_index { |v, i| x_to_i[v] = i }
y_to_i = {}
ys.each_with_index { |v, i| y_to_i[v] = i }

# "cells" are bands between consecutive coordinates
w = xs.size - 1
h = ys.size - 1

# Precompute band widths/heights (how many integer points are represented)
dx = Array.new(w)
(0...w).each { |i| dx[i] = xs[i + 1] - xs[i] }
dy = Array.new(h)
(0...h).each { |j| dy[j] = ys[j + 1] - ys[j] }

# ---------------------------
# Step 2: Draw boundary on compressed cell grid
# boundary[r*w + c] == true means this whole band-cell is on the red/green loop line
# ---------------------------
boundary = Array.new(h * w, false)

(0...n).each do |i|
  x1, y1 = pts[i]
  x2, y2 = pts[(i + 1) % n]

  if y1 == y2
    # horizontal segment on y=y1, from xmin..xmax inclusive
    y = y1
    r = y_to_i.fetch(y) # y is in ys because we inserted y and y+1
    xmin, xmax = [x1, x2].minmax

    c_start = x_to_i.fetch(xmin)
    c_end = x_to_i.fetch(xmax + 1) - 1 # xmax is red => xmax+1 exists

    (c_start..c_end).each do |c|
      boundary[r * w + c] = true
    end
  else
    # vertical segment on x=x1, from ymin..ymax inclusive
    x = x1
    c = x_to_i.fetch(x)
    ymin, ymax = [y1, y2].minmax

    r_start = y_to_i.fetch(ymin)
    r_end = y_to_i.fetch(ymax + 1) - 1 # ymax is red => ymax+1 exists

    (r_start..r_end).each do |r|
      boundary[r * w + c] = true
    end
  end
end

# ---------------------------
# Step 3: Flood fill from outside (boundary blocks movement)
# visited == true => outside
# ---------------------------
visited = Array.new(h * w, false)
q = []
head = 0

# push all border cells as BFS seeds (outside is connected to the border thanks to padding)
(0...w).each do |c|
  idx_top = 0 * w + c
  idx_bot = (h - 1) * w + c
  unless boundary[idx_top]
    visited[idx_top] = true
    q << idx_top
  end
  unless boundary[idx_bot]
    visited[idx_bot] = true
    q << idx_bot
  end
end
(0...h).each do |r|
  idx_left  = r * w + 0
  idx_right = r * w + (w - 1)
  unless boundary[idx_left]
    visited[idx_left] = true
    q << idx_left
  end
  unless boundary[idx_right]
    visited[idx_right] = true
    q << idx_right
  end
end

while head < q.length
  idx = q[head]
  head += 1

  r = idx / w
  c = idx % w

  # left
  if c > 0
    nidx = idx - 1
    if !visited[nidx] && !boundary[nidx]
      visited[nidx] = true
      q << nidx
    end
  end
  # right
  if c + 1 < w
    nidx = idx + 1
    if !visited[nidx] && !boundary[nidx]
      visited[nidx] = true
      q << nidx
    end
  end
  # up
  if r > 0
    nidx = idx - w
    if !visited[nidx] && !boundary[nidx]
      visited[nidx] = true
      q << nidx
    end
  end
  # down
  if r + 1 < h
    nidx = idx + w
    if !visited[nidx] && !boundary[nidx]
      visited[nidx] = true
      q << nidx
    end
  end
end

# inside = not visited and not boundary
# allowed = boundary OR inside
allowed = Array.new(h * w, false)
(0...(h * w)).each do |i|
  allowed[i] = boundary[i] || (!visited[i])
end

# ---------------------------
# Step 4 & 5: Build weighted "bad" grid and its 2D prefix sum
# bad_weight[r,c] = number of integer points in this cell if NOT allowed, else 0
# ---------------------------
w1 = w + 1
ps = Array.new((h + 1) * (w + 1), 0)

(0...h).each do |r|
  row_base_ps = (r + 1) * w1
  prev_row_ps = r * w1
  (0...w).each do |c|
    cell_idx = r * w + c
    bad = allowed[cell_idx] ? 0 : (dx[c] * dy[r])

    # prefix sum recurrence
    ps[row_base_ps + (c + 1)] =
      bad +
      ps[prev_row_ps + (c + 1)] +
      ps[row_base_ps + c] -
      ps[prev_row_ps + c]
  end
end

# ---------------------------
# Step 6: Enumerate red pairs and validate rectangle by O(1) bad==0 query
# ---------------------------
max_area = 0

(0...n).each do |i|
  x1, y1 = pts[i]
  (i + 1...n).each do |j|
    x2, y2 = pts[j]

    xL, xR = [x1, x2].minmax
    yB, yT = [y1, y2].minmax

    # convert coordinate rectangle to compressed cell rectangle
    cL = x_to_i.fetch(xL)
    cR = x_to_i.fetch(xR + 1) - 1
    rB = y_to_i.fetch(yB)
    rT = y_to_i.fetch(yT + 1) - 1

    bad_points = rect_sum(ps, w1, rB, cL, rT, cR)
    next unless bad_points == 0

    area = (xR - xL + 1) * (yT - yB + 1)
    max_area = area if area > max_area
  end
end

puts max_area
