date = new Date

gbdt = date.toLocaleDateString 'en-GB', # mm/dd/yyyy
    month:  '2-digit'
    day:    '2-digit'
    year:   'numeric'
console.log gbdt.split('/').reverse().join '-'

console.log date.toLocaleDateString 'en-US',
    weekday: 'long'
    month:   'long'
    day:  'numeric'
    year: 'numeric'

pad = (n) -> if n < 10 then "0" + n else n

console.log ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][date.getDay()]
console.log "#{date.getFullYear()}.#{pad (date.getMonth()+1)}.#{pad date.getDate()}"
console.log "#{pad date.getHours()}:#{pad date.getMinutes()}:#{pad date.getSeconds()}"
console.log "Unix time: #{date.getTime()/1000} i.e. #{pad date.getMilliseconds()} ms"

