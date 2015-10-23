rot = (x,k) -> ((x<<k)&0xFFFF_FFFF)|(x>>>(32-k))
M = 100_000_000 # change to 30MB for IE
test = ->
  s = ""
  n = 0
  k = 0
  for i in [1..30_000_000] # 30 mln times
    n = rot (n + 0xFD02_D9A7), 7
    n = ((n * 0x37E) & 0xFFFF_FFFF) ^ 0x135B_3721
    n = rot n, 19
    t = Math.abs(n).toString(16)+"~"
    s += t
    k += 1
    if s.length > M # 100MB for not IE
      s = s[M//2-100..]+s[...100]
  return k//1_000_000 + " million times :: " + s[-120..-80]

t1 = (new Date).getTime()
res = test()
t2 = (new Date).getTime()

if window?
  alert res+"\n"+(t2-t1)/1000
else
  console.log res+"\n"+(t2-t1)/1000

# browser: 5.695|5.598 (IE 21.17 for 30MB)
# node.js: 10.58(11.6)|12.44/13.22 work(remotely)|home/home-4GB
# py (3M): |51
# C# 5.38 (work)
