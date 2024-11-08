darwin.add_lua_code("private_lua_c_amalgamator = {}")

local concat_path = true
local src_files = dtw.list_files_recursively("luacode", concat_path)
for i = 1, #src_files do
    local current = src_files[i]
    darwin.add_lua_code("-- file: " .. current .. "\n")
    darwin.add_lua_file(current)
end
darwin.generate_lua_output("debug.lua")

darwin.c_include("cinterop/main_lib.c")
darwin.load_lualib_from_c(
    "luaopen_private_lua_c_amalgamator_cinterop",
    "private_lua_c_amalgamator_cinterop"
)
-- we dont need to include ,since its already imported by "cinterop/main_lib.c"
local include_lua_cembed = false
darwin.generate_c_lib_output(
    "lua_c_amalgamator",
    "private_lua_c_amalgamator",
    "lua_c_amalgamator.c",
    include_lua_cembed
)
os.execute(" gcc -Wall -shared -fpic -o lua_c_amalgamator.so  lua_c_amalgamator.c")
