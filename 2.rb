MAX = 4000000

fib = Enumerator.new do |enum|
  a = 1
  b = 2
  enum.yield a
  enum.yield b
  while b < MAX
    c = a + b
    enum.yield c
    a = b
    b = c
  end
end

even = fib.select { |x| x % 2 == 0 }
sum = even.reduce(&:+)
puts sum
