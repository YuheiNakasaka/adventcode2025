# input = File.readlines('11/sample.txt')
input = File.readlines('11/input.txt')

g = {}
input.each do |line|
  line = line.chomp.split(': ')
  g[line[0]] = line[1].split(' ')
end

$ans = 0
def dfs(g, key)
  if key == 'out'
    $ans += 1
    return
  end

  g[key].each do |next_key|
    dfs(g, next_key)
  end
end

dfs(g, 'you')

p $ans
