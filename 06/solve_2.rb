input = File.readlines('06/input.txt').map{|_| _.split('').select{|o| o != "\n"}}
# input = File.readlines('06/sample.txt').map{|_| _.split('')[0..-2]}
# input.each do |line|
#   p line
# end

num = []
op = nil
ans = 0
input[0].length.times do |i|
  a0 = input[0][i]
  a1 = input[1][i]
  a2 = input[2][i]
  a3 = input[3][i]
  a4 = input[4][i]
  if a0 == ' ' && a1 == ' ' && a2 == ' ' && a3 == ' ' && a4 == ' '
    p "#{num.join(op)} = #{eval(num.join(op))}"
    ans += eval(num.join(op))
    num = []
    op = nil
  else
    if a4 != ' '
      op = a4
    end
    num << "#{a0}#{a1}#{a2}#{a3}".chomp.to_i
  end
end

puts ans
