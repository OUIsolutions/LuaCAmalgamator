CAMALGAMATOR_CODE = "32342jjressd"
CAMALGAMATOR_PATH = "dependencies/CAmalgamatorApiNoDependenciesIncluded.h"



function main()
    Install_dependencies()

    darwin.dtw.remove_any("release")

    --- we must format these , to avoid bugs on include
    local camalgamator_content = darwin.dtw.load_file(CAMALGAMATOR_PATH)
    camalgamator_content = camalgamator_content:gsub("#include", CAMALGAMATOR_CODE)
    darwin.dtw.write_file(CAMALGAMATOR_PATH, camalgamator_content)

    generate_full_c()
    generate_darwin_import()
    generate_darwin_no_dependencie_not_included()

    darwin.dtw.copy_any_overwriting("types/amalgamator_types.lua", "LuaCAmalgamator/types.lua")
    darwin.dtw.copy_any_overwriting("init.lua", "LuaCAmalgamator/init.lua")
    os.execute("gcc -shared -fpic release/lua_c_amalgamator_full.c -o LuaCAmalgamator/lua_c_amalgamator.so")
    os.execute("zip -r  release/LuaCAmalgamator.zip LuaCAmalgamator/")

end 