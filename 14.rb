CACHE = {}

def collatz_length(x)
  return 1 if x == 1
  stack = []
  while x != 1
    stack << x
    if x.even?
      x = x / 2
    else
      x = 3 * x + 1
    end
    break if CACHE[x]
  end
  chain_end = if CACHE[x] then CACHE[x] else 0 end
  stack.each_with_index do |x, i|
    CACHE[x] = stack.size + chain_end - i
  end
  stack.size + chain_end
end

puts collatz_length(8)
puts CACHE
puts collatz_length(13)
puts CACHE
puts collatz_length(40)
puts CACHE
# exit 0

max = 1
num = 1
(1..1_000_000).each do |i|
  length = collatz_length(i)
  if length > max
    max = length
    num = i
    puts "Length #{length}, i #{i}, cache size #{CACHE.size}"
  end
end

puts num
