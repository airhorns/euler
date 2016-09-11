nums = [
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20
]

i = 20
while true
  i = i + 20
  break if nums.all? { |num| i % num == 0 }
end
puts i
