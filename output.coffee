# output with or without newline and with colors
# put it to .../NodeJS/node_modules and use as {wl,wr,sc} = require "output"

if window?
  wl = wr = alert
  sc = ->
else
  wl = console.log
  wr = (x) -> process.stdout.write x
  sc = (fg='w',bg='k') ->
    if fg.length==2
      bg = fg[1]; fg = fg[0]
    f = 'krgybmcwKRGYBMCW'.indexOf fg; f = 11 if f<0
    b = 'krgybmcwKRGYBMCW'.indexOf bg; b =  0 if b<0
    "\x1b[#{f//8};#{30+f%8};#{if b<8 then 40+b%8 else 100+b%8}m"

test_output = ->
  for b in 'krgybmcwKRGYBMCW'
    for f in 'krgybmcwKRGYBMCW'
      wr "#{sc f, b} #{f}/#{b} "
    wl sc()
  wl "Тест Utf8 ÂâÎîĂăȘșȚț ♠♣♥♦ áéíóú ЄєІіЇїҐґ µ™©℃℉ ° •—… ¢€£¥₪₴ ½¼¾²³±≤≥≠≈ ♀♂↵←↑↓→⇒"

if not module.parent
  test_output()

module.exports = wl:wl, wr:wr, sc:sc, test_output:test_output
