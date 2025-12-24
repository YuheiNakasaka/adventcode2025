# おそらく選んだボタンの適用順は関係ないのでcombinationでボタンを1から選んでいき全て.にできるかを判定すればok?
def is_light_all_on(light, buttons)
  dup_light = light.dup
  buttons.each do |button|
    button.each do |b|
      if dup_light[b] == '.'
        dup_light[b] = '#'
      else
        dup_light[b] = '.'
      end
    end
  end
  dup_light.all?{|_| _ == '.'}
end

ans = 0
# inputs = File.readlines('10/sample.txt')
inputs = File.readlines('10/input.txt')
inputs.each do |input|
  line = input.chomp.split(' ')
  light = line.first.match(/\[(.+)\]/)[1].split('')
  buttons = line[1..-2].map{|_| _.chomp.match(/\((.+)\)/)[1].split(',').map(&:to_i)}
  _ = line[-1].chomp.match(/\{(.+)\}/)[1].split(',').map(&:to_i)

  # p light, buttons, _

  is_all_on = false
  (1..buttons.size).each do |i|
    break if is_all_on

    buttons.combination(i).each do |combination|
      break if is_all_on

      if is_light_all_on(light, combination)
        # p combination
        ans += combination.size
        is_all_on = true
        break
      end
    end
  end
end

puts ans
