transpose = (matrix) ->
    (t[i] for t in matrix) for i in [0...matrix[0].length]

console.log transpose [[1,2,3],[4,5,6]]
