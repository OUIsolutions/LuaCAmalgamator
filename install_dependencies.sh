rm -rf dependencies
mkdir dependencies
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.012/darwin012.c -o darwin012.c
curl -L https://github.com/OUIsolutions/CAmalgamator/releases/download/0.001/CAmalgamatorApiOne.h -o dependencies/CAmalgamatorApiOne.h
curl -L https://github.com/OUIsolutions/CAmalgamator/releases/download/0.001/CAmalgamatorApiNoDependenciesIncluded.h -o  dependencies/CAmalgamatorApiNoDependenciesIncluded.h
curl -L https://github.com/OUIsolutions/LuaCEmbed/releases/download/v0.778/LuaCEmbed.h -o dependencies/LuaCEmbed.h
