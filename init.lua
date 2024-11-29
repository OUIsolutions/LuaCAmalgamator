local info = debug.getinfo(1, "S")
local path = info.source:match("@(.*/)") or ""




local lib_path = ''

if os.getenv("HOME") then
    lib_path = path .. "lua_c_amalgamator.so"
else
    error("os not suported")
end

local load_lua = package.loadlib(lib_path, "luaopen_lua_c_amalgamator")

---@type DtwModule
local lib = load_lua()

return lib
