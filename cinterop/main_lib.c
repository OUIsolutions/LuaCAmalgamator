#include "../dependencies/LuaCEmbed.h"
LuaCEmbedNamespace  lua_n;




int luaopen_private_my_project_cinterop(lua_State *state){
    lua_n = newLuaCEmbedNamespace();
    //functions will be only assescible by the required reciver
    LuaCEmbed * l  = lua_n.newLuaLib(state);

return lua_n.perform(l);
}
