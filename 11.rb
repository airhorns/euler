require 'pp'
NUMS = [[ 8,02,22,97,38,15,00,40,00,75,04,05,07,78,52,12,50,77,91, 8],
        [49,49,99,40,17,81,18,57,60,87,17,40,98,43,69,48,04,56,62,00],
        [81,49,31,73,55,79,14,29,93,71,40,67,53,88,30,03,49,13,36,65],
        [52,70,95,23,04,60,11,42,69,24,68,56,01,32,56,71,37,02,36,91],
        [22,31,16,71,51,67,63,89,41,92,36,54,22,40,40,28,66,33,13,80],
        [24,47,32,60,99,03,45,02,44,75,33,53,78,36,84,20,35,17,12,50],
        [32,98,81,28,64,23,67,10,26,38,40,67,59,54,70,66,18,38,64,70],
        [67,26,20,68,02,62,12,20,95,63,94,39,63, 8,40,91,66,49,94,21],
        [24,55,58,05,66,73,99,26,97,17,78,78,96,83,14,88,34,89,63,72],
        [21,36,23, 9,75,00,76,44,20,45,35,14,00,61,33,97,34,31,33,95],
        [78,17,53,28,22,75,31,67,15,94,03,80,04,62,16,14, 9,53,56,92],
        [16,39,05,42,96,35,31,47,55,58,88,24,00,17,54,24,36,29,85,57],
        [86,56,00,48,35,71,89,07,05,44,44,37,44,60,21,58,51,54,17,58],
        [19,80,81,68,05,94,47,69,28,73,92,13,86,52,17,77,04,89,55,40],
        [04,52, 8,83,97,35,99,16,07,97,57,32,16,26,26,79,33,27,98,66],
        [88,36,68,87,57,62,20,72,03,46,33,67,46,55,12,32,63,93,53,69],
        [04,42,16,73,38,25,39,11,24,94,72,18, 8,46,29,32,40,62,76,36],
        [20,69,36,41,72,30,23,88,34,62,99,69,82,67,59,85,74,04,36,16],
        [20,73,35,29,78,31,90,01,74,31,49,71,48,86,81,16,23,57,05,54],
        [01,70,54,71,83,51,54,69,16,92,33,48,61,43,52,01,89,19,67,48]]

def print_matrix(matrix)
  digits = matrix.map { |a| a.compact.max }.compact.max.to_s.size
  matrix.each do |row|
    row.each {|x| printf("%#{digits}d ", x || -1) }
    puts
  end
end

def rotate_90(matrix)
  rotated = Array.new(matrix.size) { Array.new(matrix.first.size * 2) }
  midpoint = (rotated.first.size / 2) - 1

  (0...rotated.size).each do |row|
    (0..row).each do |col|
      rotated[row][midpoint - row + col] = matrix[row][col] # march across row
      rotated[row][midpoint + row - col] = matrix[col][row] # march down row
    end
  end

  rotated
end

def flip_horizontally(matrix)
  flipped = Array.new(matrix.size) { Array.new(matrix.first.size) }
  cols = flipped.first.size
  (0...flipped.size).each do |row|
    (0...cols).each do |col|
      flipped[row][col] = matrix[row][cols - 1 - col]
    end
  end

  flipped
end

def supernodes(matrix, offset, dir)
  case dir
  when :lat
    rows = matrix.size
    cols = matrix.size / 2
  when :long
    rows = matrix.size / 2
    cols = matrix.first.size
  end

  supers = Array.new(rows) { Array.new(cols) }

  (0...rows).each do |row|
    (0...cols).each do |col|
      addrs = case dir
      when :lat then [[row, col * 2 + offset], [row, col * 2 + 1 + offset]]
      when :long then [[row * 2 + offset, col], [row * 2 + 1 + offset, col]]
      else
        raise Exception, "Undetermined direction"
      end
      next if addrs.any? { |(row, col)| matrix[row].nil? || matrix[row][col].nil? }
      supers[row][col] = matrix[addrs[0][0]][addrs[0][1]] * matrix[addrs[1][0]][addrs[1][1]]
    end
  end

  supers
end

vals = []
[:lat, :long].each do |dir|
  [0, 1].each do |first_offset|
    nodes = supernodes(NUMS, first_offset, dir)
    [0, 1].each do |second_offset|
      products = supernodes(nodes, second_offset, dir)
      vals << {dir: dir, first_offset: first_offset, second_offset: second_offset, max: products.map { |row| row.compact.max }.compact.max}
    end
  end
end

[NUMS, flip_horizontally(NUMS)].each do |matrix|
  matrix = rotate_90(matrix)
  [0, 1].each do |first_offset|
    nodes = supernodes(matrix, first_offset, :long)
    [0, 1].each do |second_offset|
      products = supernodes(nodes, second_offset, :long )
      vals << {dir: :diag, first_offset: first_offset, second_offset: second_offset, max: products.map { |row| row.compact.max }.compact.max}
    end
  end
end

puts vals
puts vals.map {|v| v[:max] }.max
