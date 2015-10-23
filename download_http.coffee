http = require "http"
{wl,wr,sc} = require "./output"

urls = ["http://www.google.coffee/index.html",
        "http://www.google.com/index.html",
        "http://www.google.com.ua/index.html" ] # yeah, it redirects here. annoying

for url in urls
  do (url) -> # save url for this body, otherwise it'll be the last
    req = http.get url, (res) ->
      wl "\n#{url}\n#{sc 'Y'}Got response: #{res.statusCode}#{sc()}"
      if res.statusCode != 200
        return
      data = ''
      res.setEncoding('utf8')
      res.on 'data', (chunk) -> data += chunk
      res.on 'end', -> wl "\n#{url}\n#{sc 'C'}Data:\n#{data[...80]}\n...\n#{data[-80...]}"+
                          "#{sc()}[#{data.length}]"
    req.on 'error', (e) -> wl "\n#{url}\n#{sc 'R'}Got error: #{e.message}#{sc()}"
