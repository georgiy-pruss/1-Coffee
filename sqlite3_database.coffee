# First install sqlite3: npm install sqlite3 --save
# --save will save it as a dependency in your package.json
# See http://blog.modulus.io/nodejs-and-sqlite

fs=require "fs"
#sqlite3 = require("sqlite3").verbose()
sqlite3 = require("sqlite3")

file = "test.db"

db = new sqlite3.Database(file)

db.serialize ->
  exists = fs.existsSync(db.filename)
  if !exists
    # maybe needs fs.openSync(file, "w") before... but I doubt it, went all OK
    db.run "create table stuff (thing text)" # can be "create ... if not exists"
  stmt = db.prepare "insert into stuff values (?)"
  stmt.run "thing #ABC"
  stmt.run "thing #DEF"
  stmt.run "thing #GHI"
  stmt.finalize()
  db.each "select rowid as id,thing from stuff order by thing",
    (err,row) -> console.log row.id+" : "+row.thing
  # db.each is asynchronous! it can have the last parameter:
  # db.each([param, ...], [callback], [complete]);
  db.close()
