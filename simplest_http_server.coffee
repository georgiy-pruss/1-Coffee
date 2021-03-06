# TODO: add checks for index.htm[l]
# TODO: find out why Firefox downloads images twice
# TODO: why IE desn't show (=download)binary files

http = require 'http'
path = require 'path'
url = require 'url'
fs = require 'fs'

HOMEDIR = process.cwd() # serve it from where it started
MIMEIMG = '.jpg':'jpeg','.png':'png','.ico':'x-icon','.gif':'gif','.bmp':'x-windows-bmp'
HTMLS = /\.(htm|html|shtml)$/i
TXTS = /\.(log|txt|h|c|cpp|py|ijs|js|coffee)$/i

fmtsz = (n) -> ('          '+n)[-10..]

writepage = (res,txt,fnm='.txt') ->
  if fnm.match HTMLS
    bytelen = (unescape encodeURIComponent txt).length
    res.writeHead 200, {'Content-Type': 'text/html', 'Content-Length': bytelen}
    res.end txt
  else if fnm.match TXTS
    bytelen = (unescape encodeURIComponent txt).length
    res.writeHead 200, {'Content-Type': 'text/plain', 'Content-Length': bytelen}
    res.end txt
  else if fnm[-4..].toLowerCase() of MIMEIMG
    mime = MIMEIMG[fnm[-4..].toLowerCase()]
    res.writeHead 200, {'Content-Type': 'image/'+mime, 'Content-Length': txt.length}
    res.end txt, 'binary'
  else
    res.writeHead 200, {'Content-Type': 'application/octet-stream', 'Content-Length': txt.length}
    res.end txt, 'binary'

listdir = (res, filename, pathname) ->
  if pathname[-1..]!='/' then pathname += '/'
  parent = (pathname.split '/')[...-2].join '/'; if parent=='' then parent='/'
  files = fs.readdirSync filename
  lines = ["<html><head><meta charset='UTF-8'></head><body><pre>"]
  if pathname!='/'
    lines.push("#{fmtsz '‹DIR›'}  ......up one level......  <a href='#{parent}'>..</a>")
  for f in files
    if f != '.'
      st = fs.statSync path.join filename,f
      if st.isDirectory()
        f += '/'; st.size="‹DIR›"
      href = "#{pathname}#{f}".replace "'","\\'"
      lines.push "#{fmtsz st.size}  #{st.mtime.toISOString()}  <a href='#{href}'>#{f}</a>"
  lines.push "</pre></body></html>"
  writepage res, lines.join('\n'), '.htm'

listener = (req, res) ->                   # 'GET'    '/abcd?xyz=2'
  console.log "#{(new Date).toISOString()} #{req.method} #{req.url}"
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
  pathname = unescape(url.parse(req.url).pathname)
  filename = path.join HOMEDIR, pathname
  fs.exists filename, (exists) ->
    if not exists
      res.writeHead 404; res.end(); return
    if fs.statSync(filename).isDirectory()
      listdir res, filename, pathname; return
    utf8 = filename.match(HTMLS) or filename.match(TXTS)
    fs.readFile filename, (if utf8 then 'utf8' else 'binary'), (err, filetxt) ->
      if err
        writepage res, "#{err}"; return # or code 500
      writepage res, filetxt, filename

http.createServer( listener ).listen 8000

console.log 'Server running at http://127.0.0.1:8000/'
