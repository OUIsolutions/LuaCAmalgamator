darwin.add_lua_file("types.lua")
darwin.add_lua_code("private_my_project =  {}")
darwin.add_lua_code("my_project = {}")

local concat_path = true
local src_files = dtw.list_files_recursively("lua_code", concat_path)
for i = 1, #src_files do
    local current = src_files[i]
    darwin.add_lua_code("-- file: " .. current .. "\n")
    darwin.add_lua_file(current)
end


darwin.c_include("cinterop/main_lib.c")
darwin.load_lualib_from_c(
    "luaopen_private_my_project_cinterop",
    "private_my_project_cinterop"
)
-- we dont need to include ,since its already imported by "cinterop/main_lib.c"
local include_lua_cembed = false
darwin.generate_c_lib_output(
    "my_project",
    "my_project",
    "my_project.c",
    include_lua_cembed
)
os.execute(" gcc -Wall -shared -fpic -o my_project.so  my_project.c")
