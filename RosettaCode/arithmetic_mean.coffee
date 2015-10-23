mean = (arr) ->
 return 0 if arr.length is 0
 sum = arr.reduce ((s,e) -> s += e), 0
 sum / arr.length


console.log mean [1,2,3,4]
