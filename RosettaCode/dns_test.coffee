# runs under node.js
dns = require 'dns'

dns.resolve4 'www.kame.net', (err, addresses) ->
  console.log 'IP4'
  console.log addresses

dns.resolve6 'www.kame.net', (err, addresses) ->
  console.log 'IP6'
  console.log addresses

###
IP4
[ '203.178.141.194' ]
IP6
[ '2001:200:dff:fff1:216:3eff:feb1:44d7' ]
###
