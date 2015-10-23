# Coffee
CoffeeScript programs - starting with tests, going to utitities :)

Note, my coffeescript engine can deal with underscores in numbers.

## NodeJS and CoffeeScript on Windows Tips

NodeJS is installed in C:/BIN/nodejs  
set PATH=...;C:\BIN\nodejs;...  
set NODE_PATH=C:/BIN/nodejs/node_modules  
Installed CoffeeScript and others...
By default npm installs all into C:\Users\...\AppData\Roaming\npm\node_modules\  
with -g key, and to current directory without it. E.g.  
C:\Users\...\AppData\Roaming\npm\node_modules\coffee-script\  
C:\Users\...\AppData\Roaming\npm\node_modules\colors\  
You can move them to C:\BIN\nodejs\node_modules\ if NODE_PATH is set
Files cake.* and coffee.* I also moved to C:\BIN\nodejs\
set PATHEXT=...;.COFFEE;...
assoc .coffee=CoffeeScript
ftype CoffeeScript=C:\BIN\nodejs\coffee.cmd "%1" %*
echo "@C:\BIN\nodejs\coffee.cmd %*" >C:\BIN\co.bat
