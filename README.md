# Coffee
CoffeeScript programs - starting with tests, going to utitities :)

Note, my coffeescript engine can deal with underscores in numbers (b/c of [lexer](https://github.com/georgiy-pruss/CoffeeScriptToo/blob/master/lib/coffee-script)).

## NodeJS and CoffeeScript on Windows Tips

NodeJS is installed in C:/BIN/NodeJS  
set **PATH**=...;C:\BIN\NodeJS;...  
set **NODE_PATH**=C:/BIN/NodeJS/node_modules  
Install CoffeeScript and other modules...  
By default npm installs all into the current directory, or  
with -g key to directory *C:\Users\\...\AppData\Roaming\npm\node_modules\* E.g.  
*C:\Users\\...\AppData\Roaming\npm\node_modules\coffee-script\*  
*C:\Users\\...\AppData\Roaming\npm\node_modules\colors\*  
You can move them all to C:\BIN\NodeJS\node_modules\ if NODE_PATH is set  
Also move files like cake.* and coffee.* -- to C:\BIN\NodeJS\ itself   

echo @C:\BIN\NodeJS\coffee.cmd %* >C:\BIN\co.bat  
set **PATHEXT**=...;.COFFEE;...  
assoc .coffee=CoffeeScript  
ftype CoffeeScript=C:\BIN\NodeJS\coffee.cmd "%1" %*  

Increase memory limit:
coffee --nodejs --max-old-space-size=4000 prog_eats_memory.coffee

Icon:  
[HKEY_CLASSES_ROOT\CoffeeScript\DefaultIcon]  
@="C:\\BIN\\NodeJS\\node_modules\\coffee-script\\coffeescript.ico"  
