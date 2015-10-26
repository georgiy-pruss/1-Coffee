# https://github.com/niftylettuce/stockscraper (G-: js->coffeescript)
# G-: request -> https

https = require "https"

get = (market, ticker, cb) ->
  if !ticker || !market
    throw new Error 'invalid args'
  url="https://www.google.com/finance/info?&q=#{market}:#{ticker}"
  req = https.get url, (res) ->
    if res.statusCode != 200
      console.log "Status: #{res.statusCode}"
      cb new Error 'Invalid request: status'
    else
      data = ''
      res.on 'data', (chunk) -> data += chunk
      res.on 'end', -> cb null, data
  req.on 'error', (e) ->
      console.log "Error: #{e.message}"
      cb new Error 'Invalid request: error'

clean = (data, cb) ->
  string = data.replace('[','').replace(']','').replace('//','')
  jsonBody = JSON.parse string
  cb null, jsonBody

scrape = (market, ticker, cb) ->
  get market, ticker, (err, data) ->
    if err then cb err else clean data, cb

module.exports = {scrape}

if !module.parent
  scrape 'NASDAQ', 'AAPL', (err, data) -> console.log data

###
Example:
stockscraper = require 'stockscraper'
stockscraper.scrape 'NASDAQ', 'AAPL', (err, data) -> console.log data
{ id: '22144',
  t: 'AAPL',
  e: 'NASDAQ',
  l: '119.08',
  l_fix: '119.08',
  l_cur: '119.08',
  s: '0',
  ltt: '4:00PM EDT',
  lt: 'Oct 23, 4:00PM EDT',
  lt_dts: '2015-10-23T16:00:01Z',
  c: '+3.58',
  c_fix: '3.58',
  cp: '3.10',
  cp_fix: '3.10',
  ccol: 'chg',
  pcls_fix: '115.5' }
###
