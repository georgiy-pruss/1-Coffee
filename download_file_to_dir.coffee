# http://www.hacksparrow.com/using-node-js-to-download-files.html
# G-: js --> coffeescript and to Windows

fs = require 'fs'
url = require 'url'
http = require 'http'              # better use needle
{exec} = require 'child_process'
# better use https://github.com/substack/node-mkdirp

# App variables
file_url = 'http://mas.orgfree.com/favicon.ico'
DOWNLOAD_DIR = 'downloads'

# We will be downloading the files to a directory, so make sure it's there
# This step is not required if you have manually created the directory
if not fs.existsSync DOWNLOAD_DIR
  mkdir = 'mkdir ' + DOWNLOAD_DIR
  exec mkdir, (err, stdout, stderr) ->
    if err then throw err
else if not fs.lstatSync(DOWNLOAD_DIR).isDirectory()
  throw "#{DOWNLOAD_DIR} is not directory"

# Function to download file using HTTP.get
download_file_httpget = (file_url) ->
  options =
    host: url.parse(file_url).host
    port: 80
    path: url.parse(file_url).pathname
  file_name = url.parse(file_url).pathname.split('/').pop()
  file_stm = fs.createWriteStream "#{DOWNLOAD_DIR}\\#{file_name}"
  http.get options, (res) ->
    if res.statusCode != 200
      console.log "#{file_url}\nGot response: #{res.statusCode}"
      return
    res.on 'data', (data) -> file_stm.write data
    res.on 'end', ->
      file_stm.end()
      console.log "File '#{file_name}' downloaded to '#{DOWNLOAD_DIR}'"
download_file_httpget file_url

###
other examples of d/l:

request('http://google.com/doodle.png').pipe(fs.createWriteStream('doodle.png'))

fs.createReadStream('file.json').pipe(request.put('http://mysite.com/obj.json')) # PUT

request.get('http://google.com/img.png').pipe(request.put('http://mysite.com/img.png'))

request.get('http://some.server.com/').auth('username', 'password', false);
###
