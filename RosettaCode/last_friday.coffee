last_friday_of_month = (year, month) ->
  # month is 1-based, JS API is 0-based, then we use
  # non-positive indexes to work backward relative to the
  # first day of the next month
  i = 0
  loop
    last_day = new Date(year, month, i)
    if last_day.getDay() == 5
      return last_day.toDateString()
    i -= 1

print_last_fridays_of_month = (year) ->
  for month in [1..12]
    console.log last_friday_of_month year, month

do ->
  if process.argv.length == 3
    year = parseInt process.argv[2]
    print_last_fridays_of_month year
  else
    console.log "Provide a year as an argument"
