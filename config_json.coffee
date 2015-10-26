fs = require 'fs'
path = require 'path'
{wl} = require 'output'

ph = process.env.HOME ? process.env.HOMEDRIVE+process.env.HOMEPATH
cf = path.join ph, '_json_test'
if not fs.existsSync cf
  wl "File #{cf} is not found"
else
  wl data = JSON.parse fs.readFileSync cf
  wl data.widget.window.size, data.widget.image.coords, data.widget.text.coords

### $HOME/_json_test
{"widget": {
    "debug": "on",
    "window": {
        "title": "Sample Konfabulator Widget",
        "name": "main_window",
        "size": [ 500, 500 ]
    },
    "image": {
        "src": "Images/Sun.png",
        "name": "sun1",
        "coords": [ 250, 250 ]
    },
    "text": {
        "data": "Click Here",
        "size": 36,
        "style": "bold",
        "name": "text1",
        "coords": [ 250, 100 ],
        "onMouseUp": "sun1.opacity = (sun1.opacity / 100) * 90;"
    }
}}
###
