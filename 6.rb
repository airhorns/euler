NUM = 100

range = 1..NUM
sum_of_squares = range.map {|e| e ** 2}.reduce(&:+)
square_of_sum = range.reduce(&:+)**2

puts square_of_sum - sum_of_squares
