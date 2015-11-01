# from https://github.com/bahamas10/dotfiles/blob/master/bashrc

os = require 'os'
free = os.freemem();   free_mb = Math.round free/1024/1024
total = os.totalmem(); total_mb = Math.round total/1024/1024
used = total - free;   used_mb = Math.round used/1024/1024
used_percent = Math.round( used*100/total )
console.log "used: #{used_mb} MiB / #{total_mb} MiB (#{used_percent}%), free: #{free_mb} MiB"
