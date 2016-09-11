ONES = {
  1 => "one",
  2 => "two",
  3 => "three",
  4 => "four",
  5 => "five",
  6 => "six",
  7 => "seven",
  8 => "eight",
  9 => "nine"
}

TEENS = {
  10 => "ten",
  11 => "eleven",
  12 => "twelve",
  13 => "thirteen",
  14 => "fourteen",
  15 => "fifteen",
  16 => "sixteen",
  17 => "seventeen",
  18 => "eighteen",
  19 => "nineteen"
}

TENS = {
  20 => "twenty",
  30 => "thirty",
  40 => "forty",
  50 => "fifty",
  60 => "sixty",
  70 => "seventy",
  80 => "eighty",
  90 => "ninety"
}

HUNDRED = "hundred"
AND = "and"

NUMS = {}

def ninety_nine(offset, prefix)
  ONES.each do |k, v|
    NUMS[offset + k] = prefix + v
  end
  TEENS.each do |k, v|
    NUMS[offset + k] = prefix + v
  end
  TENS.each do |ten, ten_prefix|
    NUMS[offset + ten] = prefix + ten_prefix
    ONES.each do |one, word|
      NUMS[offset + ten + one] = prefix + ten_prefix + word
    end
  end
end

ninety_nine(0, "")

ONES.each do |hundred_count, hundred_count_prefix|
  hundred = hundred_count * 100
  NUMS[hundred] = hundred_count_prefix + HUNDRED
  ninety_nine(hundred, hundred_count_prefix + HUNDRED + AND)
end

NUMS[1000] = "onethousand"
puts NUMS.values.map(&:size).reduce(&:+)
