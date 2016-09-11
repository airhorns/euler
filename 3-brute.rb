NUM = 600851475143
# NUM = 400
# NUM = 13195
THREADCOUNT = 8

def prime?(num)
  return false if num <= 1
  (3...num).step(2) do |candidate|
    return false if num % candidate == 0
  end
  return true
end

threads = (0...THREADCOUNT).map do |outer_offset|
  Thread.new(outer_offset) do |offset|
    candidate = NUM/2 - offset
    while candidate > 0
      if NUM % candidate == 0 && prime?(candidate)
        puts Thread.current
        puts candidate
        exit 0
      end
      candidate = candidate - THREADCOUNT
    end
  end
end

threads.each { |thr| thr.join }

puts "Can't find a prime factor"
