def prime_sieve(primes_up_to)
  data = Array.new(primes_up_to, true)
  (2...primes_up_to**0.5).each do |i|
    if data[i] == true # this is prime, mark all multiples as not prime
      (i**2...primes_up_to).step(i) do |j|
        data[j] = false
      end
    end
  end
  data.enum_with_index.map do |primeness, i|
    if i > 1 && primeness
      i
    else
      nil
    end
  end.compact
end

primes = prime_sieve(14_000_000)
below_2mil = primes.select { |x| x < 2_000_000 && x > 1}
unless below_2mil.size < primes.size
  puts "Didn't calculate enough primes"
  exit 1
end
puts below_2mil.size
puts below_2mil.last
puts below_2mil[0...10]
puts below_2mil.reduce(&:+)
