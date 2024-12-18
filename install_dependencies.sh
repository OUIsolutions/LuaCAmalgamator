rm -rf dependencies
mkdir dependencies
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.013/darwin013.c -o darwin013.c
curl -L https://github.com/OUIsolutions/LuaCEmbed/releases/download/v0.779/LuaCEmbed.h -o dependencies/LuaCEmbed.h

#CAmalgamator
curl -L https://github.com/OUIsolutions/CAmalgamator/releases/download/0.001/CAmalgamatorApiNoDependenciesIncluded.h -o  dependencies/CAmalgamatorApiNoDependenciesIncluded.h
curl -L https://github.com/OUIsolutions/CTextEngine/releases/download/v2.002/CTextEngine.h -o dependencies/CTextEngine.h
curl -L https://github.com/OUIsolutions/DoTheWorld/releases/download/v7.006/doTheWorld.h -o dependencies/doTheWorld.h
curl -L https://github.com/OUIsolutions/C-Cli-Entry/releases/download/0.001/CliEntry.h -o  dependencies/CliEntry.h
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.015/darwin.out -o darwin.out
chmod +x darwin.out