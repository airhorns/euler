require 'byebug'

def palindrome?(n)
  n = n.to_s
  (0...n.size/2).all? {|e| n[e] == n[-(e+1)] }
end

puts false == palindrome?(1234)
puts true == palindrome?(1001)
puts false == palindrome?(1011)
puts false == palindrome?(1101)
puts true == palindrome?(10001)
puts false == palindrome?(01001)
puts false == palindrome?(11001)
puts true == palindrome?(11011)
puts true == palindrome?(11111)

candidates = []

(-999..-100).each do |a|
  (-999..-100).each do |b|
    candidate = a * b
    if palindrome?(candidate)
      candidates << candidate
    end
  end
end

puts candidates.max
