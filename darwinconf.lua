darwin.add_lua_code("public_lua_c_amalgamator = {}")

local concat_path = true
local src_files = dtw.list_files_recursively("luacode", concat_path)
for i = 1, #src_files do
    local current = src_files[i]
    darwin.add_lua_code("-- file: " .. current .. "\n")
    darwin.add_lua_file(current)
end

darwin.generate_lua_output("debug.lua")
--darwin.add_c_file("cinterop.c", true)

--darwin.load_lualib_from_c(
--    "luaopen_private_lua_c_amalgamator_cinterop",
--    "private_lua_c_amalgamator_cinterop"
--)


darwin.generate_c_lib_output({
    libname = "lua_c_amalgamator",
    object_export = "public_lua_c_amalgamator",
    output_name = "lua_c_amalgamator.c",
    include_e_luacembed = false

})
--os.execute(" gcc -Wall -shared -fpic -o lua_c_amalgamator.so  lua_c_amalgamator.c")
