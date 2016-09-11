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


puts prime_sieve(200000)[10001]
