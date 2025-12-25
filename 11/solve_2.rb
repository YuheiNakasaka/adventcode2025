# input = File.readlines('11/sample2.txt')
input = File.readlines('11/input.txt')

g = {}
input.each do |line|
  line = line.chomp.split(': ')
  g[line[0]] = line[1].split(' ')
end

$paths = []
def dfs(g, key, path)
  if key == 'out'
    $paths << path
    return
  end

  g[key].each do |next_key|
    dfs(g, next_key, "#{path} #{key}")
  end
end

dfs(g, 'svr', '')

paths = $paths.map{|_| _.split(' ')}

ans = 0
paths.each do |path|
  if path.include?('fft') && path.include?('dac')
    ans += 1
  end
end

puts ans
