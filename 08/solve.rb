# UnionFind使いそうな雰囲気なので過去使ってたコードを流用
# https://github.com/YuheiNakasaka/playground-rb/blob/6ce7623d253a8463bf81e04c2ca40c86ef21adde/atcoder/abc287/c.rb#L2

class UnionFind
  attr_reader :siz, :par

  def initialize(n)
    @par = Array.new(n, -1)
    @siz = Array.new(n, 1)
  end

  def root(x)
    if @par[x] == -1
      x
    else
      @par[x] = root(@par[x])
    end
  end

  def is_same(x, y)
    root(x) == root(y)
  end

  def unite(x, y)
    x = root(x)
    y = root(y)
    if x == y
      return false
    end

    if @siz[x] < @siz[y]
      tmp = x
      x = y
      y = tmp
    end

    @par[y] = x
    @siz[x] += @siz[y]

    return true
  end

  def size(x)
    @siz[root(x)]
  end
end

# input = File.readlines('08/sample.txt').map{|_| _.chomp.split(',').map(&:to_i)}
input = File.readlines('08/input.txt').map{|_| _.chomp.split(',').map(&:to_i)}

table = {}
input.each_with_index do |v, id|
  table[v] = id
end
n = input.length

distances = {}
n.times do |i|
  n.times do |j|
    next if input[i] == input[j]

    d = Math.sqrt((input[i][0] - input[j][0])**2 +
    (input[i][1] - input[j][1])**2 +
    (input[i][2] - input[j][2])**2)

    distances[[input[i], input[j]].sort] = d
  end
end

distances = distances.sort_by{|k, v| v}

uf = UnionFind.new(n + 1)

# 10.times do |i|
1000.times do |i|
  p distances[i][0], distances[i][1]
  dn, dm = distances[i][0]
  uf.unite(table[dn], table[dm])
end

# p uf.siz.uniq.inject(:*)
# p uf
p uf.siz.uniq.max(3)
p uf.siz.uniq.max(3).inject(:*)
