a = [10,20,30]
console.log "a = [10,20,30]"

console.log "for v in a"
for v in a
  console.log v # 10, 20, 30

console.log "for i,v in a"
for i,v in a
  console.log i,v # 10,0; 20,1; 30,2

console.log "for i of a -- uses javascript's 'in'"
for i of a
  console.log i # 0, 1, 2

console.log "for i,v of a"
for i,v of a
  console.log i,v

console.log "20 in a: #{20 in a}, 40 in a: #{40 in a}" # true, false

d = {x:11, y:22, z:33}
console.log "\nd = {x:11, y:22, z:33}"

console.log "for k in d -- uses d.length, so nothing"
console.log "for k,v in d -- uses d.length, so nothing"

console.log "for k of d"
for k of d
  console.log k # x, y, z

console.log "for k,v of d"
for k,v of d
  console.log k,v # x,11; y,22; z,33

console.log "'x' of d: #{'x' of d}, '#' of d: #{'#' of d}" # true, false
