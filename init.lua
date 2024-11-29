local info = debug.getinfo(1, "S")
local path = info.source:match("@(.*/)") or ""




local lib_path = ''

if os.getenv("HOME") then
    lib_path = path.."lua_c_amalgamator.so"
else
   error("os not suported")
end 


local load_camalgamator = package.loadlib(lib_path, "luaopen_lua_c_amalgamator")

---@type Amalgamator
local lib = load_camalgamator()

return lib