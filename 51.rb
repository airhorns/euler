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

def pattern_permutations(string_prime)
  digits = string_prime.split("")
  duplicates = digits.each_with_object(Hash.new(0)) {|digit, obj| obj[digit] += 1 }.select {|k, v| v > 1}
  patterns = []

  duplicates.each do |digit, count|
    case count
    when 2
      patterns << string_prime.gsub(digit, "*")
    when 3..6
      indexes = digits.each_index.select {|i| digits[i] == digit }
      (2..count).each do |replacement_count|
        indexes.combination(replacement_count).each do |replacement_indexes|
          pattern = string_prime.dup
          replacement_indexes.each { |i| pattern[i] = "*" }
          patterns << pattern
        end
      end
    end
  end

  patterns
end

puts pattern_permutations("56663")
puts pattern_permutations("44455")

counts = Hash.new(0)
firsts = {}

primes = prime_sieve(2_000_000)
primes.each do |prime|
  next if prime < 50000
  string_prime = prime.to_s

  pattern_permutations(string_prime).each do |pattern|
    counts[pattern] += 1
    firsts[pattern] ||= string_prime

    if counts[pattern] == 8
      puts "Found pattern with 8 count: #{pattern}, first is #{firsts[pattern]}"
      exit 0
    end
  end
end

puts counts["56**3"]
puts "No patterns found max is #{counts.values.max} at #{counts.max_by {|k, v| v }}"
