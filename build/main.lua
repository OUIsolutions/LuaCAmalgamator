CAMALGAMATOR_CODE = "32342jjressd"
CAMALGAMATOR_PATH = "dependencies/CSilverChainApiNoDependenciesIncluded.h"



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

    darwin.dtw.copy_any_overwriting("types/luaSilverCHain_types.lua", "LuaSilverChain/types.lua")
    darwin.dtw.copy_any_overwriting("init.lua", "LuaSilverChain/init.lua")

    os.execute("gcc -shared -fpic release/silverchain_full.c -o LuaSilverChain/silverchain.so")
    os.execute("zip -r  release/LuaSilverChain.zip LuaSilverChain")


end 