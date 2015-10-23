entropy = (s) ->
    freq = (s) ->
        result = {}
        for ch in s.split ""
            result[ch] ?= 0
            result[ch]++
        return result

    frq = freq s
    n = s.length
    ((frq[f]/n for f of frq).reduce ((e, p) -> e - p * Math.log(p)), 0) * Math.LOG2E

console.log "The entropy of the string '1223334444' is #{entropy '1223334444'}"

# The entropy of the string '1223334444' is 1.8464393446710157

H = (s) -> console.log "Entropy is #{entropy s}"

(H "♖♘♗♕♔♗♘♖♙♙♙♙♙♙♙♙♙") # 2.05632607578088
(H "EchoLisp") # 3
(H "Longtemps je me suis couché de bonne heure") # 3.860828877124944
(H "azertyuiopmlkjhgfdsqwxcvbn") # 4.700439718141092

