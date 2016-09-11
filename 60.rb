require 'set'

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


SIZE = 5
CANDIDATE_SIZE_THRESHOLD = 9999

collisions = Hash.new {|h, k| h[k] = Set.new([k]) }
primes = prime_sieve(10**(CANDIDATE_SIZE_THRESHOLD.to_s.size * 2 -1))
prime_set = Set.new(primes)
primes.select {|p| p < CANDIDATE_SIZE_THRESHOLD }.combination(2).each do |(a, b)|
  a_string = a.to_s
  b_string = b.to_s
  if prime_set.include?((a_string+b_string).to_i) && prime_set.include?((b_string+a_string).to_i)
    collisions[a] << b
    collisions[b] << a
  end
end

primes.select {|p| p < CANDIDATE_SIZE_THRESHOLD }.each do |prime|
  next unless collisions[prime].size >= SIZE
  family_candidates = collisions[prime].select { |x| x >= prime && collisions[x].size >= SIZE }
  next unless family_candidates.size >= SIZE
  puts "#{prime}: #{family_candidates.size}"

  family_candidates.combination(SIZE).each do |family_candidate|
    next unless family_candidate.include?(prime)
    shared_presence = family_candidate.map {|x| collisions[x] }.reduce do |family, candidate|
      break unless family.size >= SIZE
      family.intersection(candidate)
    end
    if !shared_presence.nil? && shared_presence.size >= SIZE
      puts "Found family of primes: #{shared_presence.inspect}, sum: #{shared_presence.reduce(&:+)}"
    end
  end
end
