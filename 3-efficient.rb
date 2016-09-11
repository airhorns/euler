NUM = 600851475143
# NUM = 400
# NUM = 13195

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
    if i > 0 && primeness
      i
    else
      nil
    end
  end.compact
end

def trial_division(n)
  return [] if n < 2

  prime_factors = []
  prime_sieve(n**0.5).each do |prime|
    break if prime**2 > n
    if n % prime == 0
      prime_factors << prime
      n = n / prime
    end
  end

  if n > 1
    prime_factors << n
  end

  prime_factors
end

prime_factors = trial_division(NUM)
puts prime_factors
puts
puts prime_factors[-1]
