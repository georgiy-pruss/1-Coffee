is_prime = (n) ->
  # simple prime detection using trial division, works for all integers
  return false if n <= 1 # by definition
  return true if n in [2,3,5,7] # known primes
  return false if n % 2 == 0 # even number
  p = 3
  while p * p <= n
    return false if n % p == 0
    p += 2
  true

for i in [-1..100]
  console.log i if is_prime i

for i in [0x11223344556677..0x11223344556677+100]
  console.log "#{i} (#{i.toString(16)})" if is_prime i

