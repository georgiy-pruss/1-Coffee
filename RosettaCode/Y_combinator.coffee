Y = (f) -> g = f( (t...) -> g(t...) )

# or

Y = (f) -> ((h)->h(h))((h)->f((t...)->h(h)(t...)))

fac = Y( (f) -> (n) -> if n > 1 then n * f(n-1) else 1 )
fib = Y( (f) -> (n) -> if n > 1 then f(n-1) + f(n-2) else n )

console.log fac 10
console.log fib 10
