
LuaCAmalgamator its a wrapper of the [CAmalgamator](https://github.com/OUIsolutions/CAmalgamator)
project design to create amalgamations of C codes

### Install
if you want to install , just type:
```shell
curl -L https://github.com/OUIsolutions/LuaCAmalgamator/releases/download/0.001/LuaCAmalgamator.zip -o LuaCAmalgamator.zip && unzip LuaCAmalgamator.zip && rm LuaCAmalgamator.zip
```
### Making a Amalgamation

for making a amalgamation you can just code:
```lua
---@type Amalgamator
camalgamator = require("LuaCAmalgamator")
local max_content = camalgamator.ONE_MB * 10
local max_recursion = 100
result = camalgamator.generate_amalgamation("main.c", max_content, max_recursion)
io.open("out.c", "w"):write(result)

``

### Making a Amalgamation with validators
if you want you can make a amalgamation using validators, to define behavior
for each import
```lua
---@type Amalgamator
---@type Amalgamator
camalgamator = require("LuaCAmalgamator")
local max_content = camalgamator.ONE_MB * 10
local max_recursion = 100
result = camalgamator.generate_amalgamation_with_callback("main.c",
    function(import, path)
        print("import:", import)
        print("path:", path)
        print("-------------")
        return "include-once"
    end,
    max_content,
    max_recursion
)

io.open("out.c", "w"):write(result)

```

the code return can be betwen
|  String Var   | Description |
|--------------|---------|
|"dont-include"| dont make the inclusion and hide the text of **#include** |
|"dont-change" | dont change the **#include**|
|"include-once"|include the content once |
|"include-perpetual"|  include the content, every time it founds it  |

## Unsing in Darwin
if you want to add it inside darwin, you can generate a full static compilation
following these:
### Download the darwin version
```shell
curl -L https://github.com/OUIsolutions/LuaCAmalgamator/releases/download/0.001/lua_c_amalgamator_darwin_import.c  -o lua_c_amalgamator_darwin_import.c
```
then add the import to your **darwinconf.lua** file and the lib will be acessible as
**camalgamator** object
```lua
darwin.c_include("lua_c_amalgamator_darwin_import.c")
darwin.load_lualib_from_c(
    "luaopen_lua_c_amalgamator",
    "camalgamator"
)
```


### Building From Scracth 
if you want to build the project from scracth ,just  clone the repo and type:

```shell
sh install_dependencies.sh  && sh compiledarwin.sh  && ./darwin.o build 
```