crc32 = do ->
  table =
    for n in [0..255]
      for [0..7]
        if n & 1
          n = 0xEDB88320 ^ n >>> 1
        else
          n >>>= 1
      n
  (str, crc = -1) ->
    for c in str
      crc = crc >>> 8 ^ table[(crc ^ c.charCodeAt 0) & 255]
    (crc ^ -1) >>> 0

test = (crc32 'The quick brown fox jumps over the lazy dog').toString 16
if test=="414fa339"
  console.log "ok",test
else
  console.log "failure",test

