
function Install_dependencies()
    os.execute("mkdir -p dependencies")

    local libs = {
        {url="https://github.com/OUIsolutions/LuaCEmbed/releases/download/v0.779/LuaCEmbed.h",path="dependencies/LuaCEmbed.h"},
        {url="https://github.com/OUIsolutions/SilverChain/releases/download/0.2.1/SilverChainApiNoDependenciesIncluded.h",path="dependencies/CSilverChainApiNoDependenciesIncluded.h"},
        {url="https://github.com/OUIsolutions/CTextEngine/releases/download/v2.002/CTextEngine.h",path="dependencies/CTextEngine.h"},   
        {url="https://github.com/OUIsolutions/DoTheWorld/releases/download/v8.002/doTheWorld.h",path="dependencies/doTheWorld.h"},
        {url="https://github.com/OUIsolutions/C-Cli-Entry/releases/download/0.001/CliEntry.h",path="dependencies/CliEntry.h"},
    }
    for _, lib in ipairs(libs) do
        local executor = function()
            os.execute("curl -L " .. lib.url .. " -o " .. lib.path)
        end
        local side_effect_verifier = function()
            return darwin.dtw.generate_sha_from_file(lib.path)
        end
        cache_execution({ "download", lib.url, lib.path }, executor, side_effect_verifier)

    end
end