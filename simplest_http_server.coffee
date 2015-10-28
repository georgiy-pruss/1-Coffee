# TODO: add checks for index.htm[l]
# TODO: find out why Firefox downloads images twice
# TODO: why IE desn't show .coffee or .7z

http = require 'http'
url = require 'url'
path = require("path")
fs = require("fs")

HOMEDIR = process.cwd() # serve it from where it started
MIMEIMG = ".jpg":"jpeg",".png":"png",".ico":"x-icon",".gif":"gif"

fmtsz = (n) -> ("          "+n)[-10..]

writepage = (res,txt,fnm=".txt") ->
  if fnm[-4..]==".htm" or fnm[-5..]==".html"
    res.writeHead 200, {'Content-Type': 'text/html', 'Content-Length': txt.length}
    res.end txt
  else if fnm[-4..] in [".log",".txt"]
    res.writeHead 200, {'Content-Type': 'text/plain', 'Content-Length': txt.length}
    res.end txt
  else if fnm[-4..] of MIMEIMG
    res.writeHead 200, {'Content-Type': 'image/'+MIMEIMG[fnm[-4..]], 'Content-Length': txt.length}
    res.end txt, "binary"
  else
    res.writeHead 200, {'Content-Type': 'application/octet-stream', 'Content-Length': txt.length}
    res.end txt, "binary"

listdir = (res, filename, pathname) ->
  if pathname[-1..]!='/' then pathname += '/'
  files = fs.readdirSync filename
  lines = ["<html><head><meta charset='UTF-8'></head><body><pre>"]
  for f in files
    if f != '.'
      st = fs.statSync path.join filename,f
      if st.isDirectory()
        f += '/'; st.size="‹DIR›"
      lines.push "#{fmtsz st.size}  #{st.mtime.toISOString()}  <a href='#{pathname}#{f}'>#{f}</a>"
  lines.push "</pre></body></html>"
  writepage res, lines.join("\n"), ".htm"

g_cntr = 0 # this counter mainly shows that images are downloaded twice :( dunno why
listener = (req, res) ->                              # 'GET'    '/abcd?xyz=2'
  g_cntr+=1
  console.log "#{g_cntr} #{(new Date).toISOString()} #{req.method} #{req.url}"
  # headers: { host: 'localhost:8000', connection: 'keep-alive',
  #   'user-agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:41.0) Gecko/20100101 Firefox/41.0',
  #   'accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
  #   'accept-language': 'en-US,en;q=0.5', 'accept-encoding': 'gzip, deflate',
  if req.method != 'GET'
    return # should we call res.end()?
  if req.url=='/quit'
    writepage res, 'Goodbye, Root!'; process.exit()
  if req.url=='/'
    writepage res, 'Hello, Root!'
  pathname = url.parse(req.url).pathname
  filename = path.join HOMEDIR, pathname
  fs.exists filename, (exists) ->
    if not exists
      res.writeHead 404, 'Content-Type': 'text/plain'; res.end "[404]"; return
    if fs.statSync(filename).isDirectory()
      listdir res, filename, pathname; return
    fs.readFile filename, "binary", (err, filetxt) ->
      if err
        writepage res, "#{err}"; return # or code 500
      writepage res, filetxt, filename

http.createServer( listener ).listen 8000

console.log 'Server running at http://127.0.0.1:8000/'
