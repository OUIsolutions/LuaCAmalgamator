#include "../dependencies/LuaCEmbed.h"
#include "../dependencies/doTheWorld.h"
#include "../dependencies/CTextEngine.h"
#include "../dependencies/CAmalgamatorApiNoDependenciesIncluded.h"

LuaCEmbedResponse *generate_amalgamation_simple(LuaCEmbed *args){

    CAmalgamatorErrorOrContent *error_or_content =CAmalgamator_generate_amalgamation_simple(
        LuaCEmbed_get_str_arg(args, 0),
        LuaCEmbed_get_long_arg(args,1),
        LuaCEmbed_get_long_arg(args,2)
    );

    LuaCEmbedResponse *response = NULL;
    if(error_or_content->error){
        response = LuaCEmbed_send_error(error_or_content->error_msg);
    }
    else{
        response = LuaCEmbed_send_str(error_or_content->content);
    }

    CAmalgamatorErrorOrString_free(error_or_content);
    return response;
}

int luaopen_private_lua_c_amalgamator_cinterop(lua_State *state){
    //functions will be only assescible by the required reciver
    LuaCEmbed * l = newLuaCEmbedLib(state);
    LuaCEmbed_add_callback(l,"generate_amalgamation_simple",generate_amalgamation_simple);


return LuaCembed_send_self_as_lib(l);
}
