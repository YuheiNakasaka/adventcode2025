# input = File.readlines('11/sample2.txt')
input = File.readlines('11/input.txt')

g = {}
input.each do |line|
  line = line.chomp.split(': ')
  g[line[0]] = line[1].split(' ')
end

REQUIRED_NODES = ['fft', 'dac'].freeze

$memo = {}

def count_paths(g, node, state, required_nodes)
  if node == 'out'
    all_required = (1 << required_nodes.size) - 1
    return (state == all_required) ? 1 : 0
  end

  $memo[node] ||= {}
  return $memo[node][state] if $memo[node].key?(state)

  count = 0
  g[node].each do |next_node|
    next_state = state
    required_nodes.each_with_index do |required_node, idx|
      if next_node == required_node
        next_state |= (1 << idx)
      end
    end

    count += count_paths(g, next_node, next_state, required_nodes)
  end

  $memo[node][state] = count
  count
end

ans = count_paths(g, 'svr', 0, REQUIRED_NODES)
puts ans
