encode = (str) ->
    str.replace /(.)\1*/g, (w) ->
        w[0] + w.length

decode = (str) ->
    str.replace /(.)(\d+)/g, (m,w,n) ->
        new Array(+n+1).join(w)

console.log s = "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWBWWWWWWWWWWWWWW"
console.log encode s
console.log decode encode s


encode_c = (str, offset = 75) ->
    str.replace /(.)\1*/g, (w) ->
        w[0] + String.fromCharCode(offset+w.length)

decode_c = (str, offset = 75) ->
    str.split('').map((w,i) ->
        if not (i%2) then w else new Array(+w.charCodeAt(0)-offset).join(str[i-1])
    ).join('')
