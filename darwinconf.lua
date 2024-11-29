local CAMALGAMATOR_CODE = "uhvartoqa652101l356"
local CAMALGAMATOR_PATH = "dependencies/CAmalgamatorApiNoDependenciesIncluded.h"
dtw.remove_any("release")

function generate_full_c()
    private_darwin.resset_c()

    darwin.add_c_file("citerop.c", true)
    darwin.load_lualib_from_c(
        "luaopen_private_lua_c_amalgamator_cinterop",
        "private_lua_c_amalgamator_cinterop"
    )

    local full_clib = darwin.generate_c_lib_code({
        libname = "lua_c_amalgamator",
        object_export = "public_lua_c_amalgamator",
        include_e_luacembed = false
    })
    full_clib = full_clib:gsub(CAMALGAMATOR_CODE, "#include")
    dtw.write_file("release/lua_c_amalgamator_full.c", full_clib)
end

function generate_darwin_import()
    private_darwin.resset_c()

    darwin.add_c_file("citerop.c", true, function(import, path)
        if import == "dependencies/LuaCEmbed.h" then
            return false
        end
        return true
    end)
    darwin.load_lualib_from_c(
        "luaopen_private_lua_c_amalgamator_cinterop",
        "private_lua_c_amalgamator_cinterop"
    )

    local full_clib = darwin.generate_c_lib_code({
        libname = "lua_c_amalgamator",
        object_export = "public_lua_c_amalgamator",
        include_e_luacembed = false
    })
    full_clib = full_clib:gsub(CAMALGAMATOR_CODE, "#include")
    dtw.write_file("release/lua_c_amalgamator_darwin_import.c", full_clib)
end

function generate_darwin_no_dependencie_not_included()
    private_darwin.resset_c()

    darwin.add_c_file("citerop.c", true, function(import, path)
        if import ~= "dependencies/CAmalgamatorApiNoDependenciesIncluded.h" then
            return false
        end

        return true
    end)
    darwin.load_lualib_from_c(
        "luaopen_private_lua_c_amalgamator_cinterop",
        "private_lua_c_amalgamator_cinterop"
    )

    local full_clib = darwin.generate_c_lib_code({
        libname = "lua_c_amalgamator",
        object_export = "public_lua_c_amalgamator",
        include_e_luacembed = false
    })
    full_clib = full_clib:gsub(CAMALGAMATOR_CODE, "#include")
    dtw.write_file("release/lua_c_amalgamator_dependencie_not_included.c", full_clib)
end

darwin.add_lua_code("public_lua_c_amalgamator = {}")
local concat_path = true
local src_files = dtw.list_files_recursively("public", concat_path)
for i = 1, #src_files do
    local current = src_files[i]
    darwin.add_lua_code("-- file: " .. current .. "\n")
    darwin.add_lua_file(current)
end
darwin.generate_lua_output({ output_name = "debug.lua" })

--- we must format these , to avoid bugs on include
local camalgamator_content = dtw.load_file(CAMALGAMATOR_PATH)
camalgamator_content = camalgamator_content:gsub("#include", CAMALGAMATOR_CODE)
dtw.write_file(CAMALGAMATOR_PATH, camalgamator_content)


generate_full_c()
generate_darwin_import()
generate_darwin_no_dependencie_not_included()
dtw.copy_any_overwriting("types/amalgamator_types.lua", "release/LuaCAmalgamator/types.lua")
dtw.copy_any_overwriting("init.lua", "release/LuaCAmalgamator/init.lua")

os.execute("gcc -shared -fpic release/lua_c_amalgamator_full.c -o release/LuaCAmalgamator/lua_c_amalgamator.so")
os.execute("zip -r  release/LuaCAmalgamator.zip release/LuaCAmalgamator/")