str = "75
95 64
17 47 82
18 35 87 10
20 04 82 47 65
19 01 23 75 03 34
88 02 77 73 07 63 67
99 65 04 28 06 16 70 92
41 41 26 56 83 40 80 70 33
41 48 72 33 47 32 37 16 94 29
53 71 44 65 25 43 91 52 97 51 14
70 11 33 28 77 73 17 78 39 68 17 57
91 71 52 38 17 14 91 43 58 50 27 29 48
63 66 04 68 89 53 67 30 73 16 69 87 40 31
04 62 98 27 23 09 70 98 73 93 38 53 60 04 23"

numbers = str.split("\n").map {|line| line.split(" ")}
width = numbers.last.size

TRIANGLE = numbers.map do |raw_row|
  row = Array.new(width)
  start_offset = (width / 2) - (raw_row.size / 2)
  raw_row.each_with_index { |number, i| row[start_offset + i] = number.to_i }
  row
end

def print_matrix(matrix)
  digits = matrix.map { |a| a.compact.max }.compact.max.to_s.size
  matrix.each do |row|
    row.each {|x| printf("%#{digits}d ", x || -1) }
    puts
  end
end

print_matrix TRIANGLE.reverse
count = 1
sums = TRIANGLE.reverse.reduce do |sums, row|
  new_sums = []
  puts "sums: #{sums.inspect}"
  puts "row : #{row.inspect}"
  even = (count += 1).even?
  row.each_with_index do |number, col_index|
    next if number.nil?

    if even
      left = col_index
      right = [col_index + 1, width - 1].min
    else
      left = [col_index - 1, 0].max
      right = col_index
    end

    new_sums[col_index] = number + [sums[left] || 0, sums[right] || 0].max
  end
  puts "news: #{new_sums.inspect}"
  puts
  new_sums
end

puts sums.compact.max
