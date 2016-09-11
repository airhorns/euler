SUM = 1000
RANGE = 1..SUM

# generate triplets and then check sum
(1..SUM).each do |a|
  ((a+1)..SUM).each do |b|
    c = (a**2 + b**2)**0.5
    if c % 1 == 0
      # we have a pythagoran triplet
      if a + b + c == 1000
        puts "A: #{a}, B: #{b}, C: #{c}"
        puts "Product: #{a * b * c}"
        exit 0
      end
    end
  end
end

puts "No product found"
