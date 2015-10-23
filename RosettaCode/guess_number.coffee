if window?
  num = Math.ceil(Math.random() * 10)
  guess = prompt "Guess the number. (1-10)"
  while parseInt(guess) isnt num
    guess = prompt "YOU LOSE! Guess again. (1-10)"
  alert "Well guessed!"

else
  # This shows how to do simple REPL-like I/O in node.js.
  readline = require "readline"

  do ->
    number = Math.ceil(10 * Math.random())
    io = readline.createInterface process.stdin, process.stdout

    guess = ->
      io.question "Guess the number between 1 and 10: ", (answer) ->
        if parseInt(answer) == number
          # These lines allow the program to terminate.
          console.log "GOT IT!"
          io.close()
          process.stdin.destroy()
        else
          console.log "Sorry, guess again"
          guess()

    guess()
