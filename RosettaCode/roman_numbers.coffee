decimal_to_roman = (n) ->
  # This should work for any positive integer, although it
  # gets a bit preposterous for large numbers.
  if n >= 4000
    thousands = decimal_to_roman n / 1000
    ones = decimal_to_roman n % 1000
    return "M(#{thousands})#{ones}"

  s = ''
  translate_each = (min, roman) ->
    while n >= min
      n -= min
      s += roman
  translate_each 1000, "M"
  translate_each  900, "CM"
  translate_each  500, "D"
  translate_each  400, "CD"
  translate_each  100, "C"
  translate_each   90, "XC"
  translate_each   50, "L"
  translate_each   40, "XL"
  translate_each   10, "X"
  translate_each    9, "IX"
  translate_each    5, "V"
  translate_each    4, "IV"
  translate_each    1, "I"
  s

###################
tests =
  IV: 4
  XLII: 42
  MCMXC: 1990
  MMVIII: 2008
  MDCLXVI: 1666
  'M(IV)': 4000
  'M(VI)IX': 6009
  'M(M(CXXIII)CDLVI)DCCLXXXIX': 123456789
  'M(MMMV)I': 3005001

for expected, decimal of tests
  roman = decimal_to_roman(decimal)
  if roman == expected
    console.log "#{decimal} = #{roman}"
  else
    console.log "error for #{decimal}: #{roman} is wrong"


roman_to_demical = (s) ->
  # s is well-formed Roman Numeral >= I
  numbers =
    M: 1000
    D: 500
    C: 100
    L: 50
    X: 10
    V: 5
    I: 1

  result = 0
  for c in s
    num = numbers[c]
    result += num
    if old_num < num
      # If old_num exists and is less than num, then
      # we need to subtract it twice, once because we
      # have already added it on the last pass, and twice
      # to conform to the Roman convention that XC = 90,
      # not 110.
      result -= 2 * old_num
    old_num = num
  result

tests =
  IV: 4
  XLII: 42
  MCMXC: 1990
  MMVIII: 2008
  MDCLXVI: 1666

for roman, expected of tests
  dec = roman_to_demical(roman)
  console.log "error" if dec != expected
  console.log "#{roman} = #{dec}"
