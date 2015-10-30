# download images from instagram
# give it such urls like https://instagram.com/p/64MeCPISjc/
# G.Pruss 2015

fs = require 'fs'
url = require 'url'
https = require 'https'
{exec} = require 'child_process'

download_file = (fileurl,cb) ->
  req = https.get fileurl, (res) ->
    if res.statusCode != 200
      console.log "#{fileurl}\n1 Got response: #{res.statusCode}"
      return
    file_name = url.parse(fileurl).pathname.split('/').pop()
    file_stm = fs.createWriteStream file_name
    res.on 'data', (data) -> file_stm.write data
    res.on 'end', ->
      file_stm.end()
      console.log "File #{file_name} OK"
      cb file_name
  req.on 'error', (e) ->
    console.log "#{fileurl}\n2 Got error: #{e.message}"

download_text = (pageurl,cb) ->
  req = https.get pageurl, (res) ->
    if res.statusCode != 200
      console.log "#{pageurl}\n3 Got response: #{res.statusCode}"
      return
    data = ''
    res.on 'data', (chunk) -> data += chunk
    res.on 'end', ->
      cb data
  req.on 'error', (e) ->
    console.log "#{pageurl}\n4 Got error: #{e.message}"

download_instagram = (pageurl) ->
  download_text pageurl, (txt) ->
    m = /"display_src":"(https:.+\.jpg)",/.exec txt.replace( /\\\//g, "/" )
    if m
      download_file m[1], (filename) ->
        exec "start #{filename}", (err, stdout, stderr) ->
          if err then console.log "#{filename}\n5 Got error: #{err.message}"

for arg in process.argv[2...] # but sometimes it's better to d/l one by one
  download_instagram arg
