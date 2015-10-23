# First install sqlite3: npm install sqlite3 --save
# --save will save it as a dependency in your package.json
# See http://blog.modulus.io/nodejs-and-sqlite

rnd = -> 1_000_000_000 + Math.floor(Math.random()*9_000_000_000)
pad = (n) -> if n < 10 then "0" + n else n
fmt = (d) -> "#{d.getFullYear()}.#{pad (d.getMonth()+1)}.#{pad d.getDate()} "+
             "#{pad d.getHours()}:#{pad d.getMinutes()}:#{pad d.getSeconds()}"
dtm = (n) -> fmt new Date(n)

sqlite3 = require("sqlite3") # can add .verbose() -- what for?
fs=require "fs"

file = "test.db"

db = new sqlite3.Database(file)
exists = fs.existsSync(file)

db.serialize ->
  if not exists
    # maybe needs fs.openSync(file, "w") before... but I doubt it, went all OK
    db.run "create table stuff (thing text, code int, added time)" # can be "create ... if not exists"
  stmt = db.prepare "insert into stuff values (?,?,?)"
  stmt.run "Thing ABC", rnd(), (new Date).getTime()
  stmt.run "Thing DEF", rnd(), (new Date).getTime()
  stmt.run "Thing GHI", rnd(), (new Date).getTime()
  stmt.finalize()
  db.each "select rowid as id,thing,code,added from stuff order by code",
    (err,row) -> console.log "#{row.code} | #{row.thing} | #{dtm row.added} | #{row.id}"
  # db.each is asynchronous! it can have the last parameter:
  # db.each([param, ...], [callback], [complete]);
  db.close()
