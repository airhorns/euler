def prime_sieve(primes_up_to)
  data = Array.new(primes_up_to, true)
  (2...primes_up_to**0.5).each do |i|
    if data[i] == true # this is prime, mark all multiples as not prime
      (i**2...primes_up_to).step(i) do |j|
        data[j] = false
      end
    end
  end
  data.each_with_index.map do |primeness, i|
    if i > 1 && primeness
      i
    else
      nil
    end
  end.compact
end

PRIMES = prime_sieve(2000000)

def trial_division(n)
  return [] if n < 2

  prime_factors = []
  prime_exponents = []
  PRIMES.each do |prime|
    break if prime**2 > n
    if n % prime == 0
      exponent = 1
      n = n / prime
      while n % prime == 0
        n = n / prime
        exponent += 1
      end
      prime_factors << prime
      prime_exponents << exponent
    end
  end

  if n > 1
    prime_factors << n
    prime_exponents << 1
  end

  #prime_factors
  prime_exponents
end

###
### Essentially it boils down to if your number n is:
### n = a^x * b^y * c^z
### (where a, b, and c are n's prime divisors and x, y, and z are the number of times that divisor is repeated) then the total count for all of the divisors is:
### (x + 1) * (y + 1) * (z + 1).
###
def factor_count(x)
  return 2 if x < 3
  prime_exponents = trial_division(x)
  prime_exponents.map {|x| x + 1 }.reduce(&:*)
end

sum = 0
(1...100000).each do |i|
  sum += i
  factors = factor_count(sum)
  if factors > 500
    puts "Triangle number: #{sum}, factors: #{factors}"
    exit 0
  end
end

puts "Sum #{sum} has count #{factor_count(sum)}, isnt over 500"
