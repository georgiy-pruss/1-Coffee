utf2bytes = (s) -> unescape encodeURIComponent s
bytes2utf = (b) -> decodeURIComponent escape b

int2bytes = (u) -> (String.fromCharCode(i) for i in u).join ''
bytes2int = (b) -> b.charCodeAt(i) for i in [0...b.length]

hex = (n) -> if n<16 then "0"+n.toString(16) else n.toString(16)

s0 = "привет ABCDE ÂâÎîĂăȘșȚț ♠♣♥♦ áéíóú ЄєІіЇїҐґ µ™©℃℉ ° •—… ¢€£¥₪₴ ½¼¾²³±≤≥≠≈ ♀♂↵←↑↓→⇒"
console.log s0 + " [#{s0.length}]" # 82
#console.log s0.length

b0 = utf2bytes s0
#console.log b0.length

u = bytes2int b0
#console.log u.length
console.log (hex(i) for i in u).join(" ") + " [#{u.length}]" # 173

b1 = int2bytes u
#console.log b1.length
#console.log b1==b0

s1 = bytes2utf b1
#console.log s1.length
console.log if s1==s0 then "restored ok" else "error"
