


function create_start_project()
    local project = darwin.create_project("lua_silverchain")
    project.add_lua_code("public_lua_silverchain = {}")
    project.add_lua_code("private_silver_chain = {}")
    local concat_path = true
    local src_files = darwin.dtw.list_files_recursively("public", concat_path)
    for i = 1, #src_files do
        local current = src_files[i]
        project.add_lua_code("-- file: " .. current .. "\n")
        project.add_lua_file(current)
    end

    return project
end 

function generate_full_c()
    local project = create_start_project()

    project.add_c_file("citerop.c", true)
    project.load_lib_from_c(
        "luaopen_private_silverchain_cinterop",
        "private_silverchain_cinterop"
    )

    local full_clib = project.generate_c_lib_code({
        libname = "lua_silverchain",
        object_export = "public_lua_silverchain",
        include_e_luacembed = false
    })

    full_clib = full_clib:gsub(SILVER_CHAIN_CODE, "#include")
    darwin.dtw.write_file("release/silverchain_full.c", full_clib)
end

function generate_darwin_import()
    local project = create_start_project()

    project.add_c_file("citerop.c", true, function(import, path)
        if import == "dependencies/LuaCEmbed.h" then
            return false
        end
        return true
    end)
    project.load_lib_from_c(
        "luaopen_private_silverchain_cinterop",
        "private_silverchain_cinterop"
    )

    local full_clib = project.generate_c_lib_code({
        libname = "lua_silverchain",
        object_export = "public_lua_silverchain",
        include_e_luacembed = false
    })

    full_clib = full_clib:gsub(SILVER_CHAIN_CODE, "#include")
    darwin.dtw.write_file("release/silverchain_darwin_import.c", full_clib)
end

function generate_darwin_no_dependencie_not_included()
   
    local project = create_start_project()

    project.add_c_file("citerop.c", true, function(import, path)
        if import == "dependencies/CSilverChainApiNoDependenciesIncluded.h" then
            return true
        end
        return false
    end)

    project.load_lib_from_c(
        "luaopen_private_silverchain_cinterop",
        "private_silverchain_cinterop"
    )

    local full_clib = project.generate_c_lib_code({
        libname = "lua_silverchain",
        object_export = "public_lua_silverchain",
        include_e_luacembed = false
    })

    full_clib = full_clib:gsub(SILVER_CHAIN_CODE, "#include")
    darwin.dtw.write_file("release/silverchain_no_dependecie_included.c", full_clib)
end

