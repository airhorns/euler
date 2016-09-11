LIMIT = 10000

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

PRIMES = prime_sieve(LIMIT)

def trial_division(n)
  return [], [] if n < 2

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

  return prime_factors, prime_exponents
end

# http://math.stackexchange.com/questions/22721/is-there-a-formula-to-calculate-the-sum-of-all-proper-divisors-of-a-number
def sum_of_factors(n)
  prime_factors, prime_exponents = trial_division(n)
  all_factors = prime_factors.zip(prime_exponents).reduce(1) do |product, (factor, exponent)|
    product * (1..exponent).map {|i| factor**i }.reduce(1, &:+)
  end
  all_factors - n # proper factors only
end

NUMBERS = {}
1.upto(LIMIT).each do |n|
  NUMBERS[n] = sum_of_factors(n)
end

AMICABLE_NUMBERS = {}
NUMBERS.each do |k, v|
  if NUMBERS[v] == k && k != v
    AMICABLE_NUMBERS[k] = v
  end
end

puts NUMBERS[284]
puts NUMBERS[220]
puts AMICABLE_NUMBERS[284]
puts AMICABLE_NUMBERS[220]
require 'byebug'
byebug
puts AMICABLE_NUMBERS.values.reduce(&:+)
