#include "dependencies/LuaCEmbed.h"
#include "dependencies/doTheWorld.h"
#include "dependencies/CTextEngine.h"
#include "dependencies/CAmalgamatorApiNoDependenciesIncluded.h"


short private_lua_c_amalgamator_generator_callback(const char *filename,const char *include_name,void *args){
    LuaCEmbed *args_formmated = (LuaCEmbed*)args;
    LuaCEmbedTable *args_data = LuaCembed_new_anonymous_table(args_formmated);
    LuaCEmbedTable_append_string(args_data, filename);
    LuaCEmbedTable_append_string(args_data, include_name);
    LuaCEmbedTable *return_args = LuaCEmbed_run_args_lambda(args, 3, args_data,1);
    long result  = LuaCEmbedTable_get_long_by_index(return_args,0);
    if(LuaCEmbed_has_errors(args_formmated)){
          return CAMALGAMATOR_UNEXPECTED_ERROR;
    }
    return result;

}

LuaCEmbedResponse *private_lua_c_amalgamator_generate_amalgamation_simple(LuaCEmbed *args){

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

LuaCEmbedResponse *private_lua_c_amalgamator_generate_amalgamation_complex(LuaCEmbed *args){
    CAmalgamatorErrorOrContent *error_or_content =CAmalgamator_generate_amalgamation(
        LuaCEmbed_get_str_arg(args, 0),
        LuaCEmbed_get_long_arg(args,1),
        LuaCEmbed_get_long_arg(args,2),
        private_lua_c_amalgamator_generator_callback,
        (void*)args
    );
    LuaCEmbedResponse *response = NULL;

    if(LuaCEmbed_has_errors(args)){
          CAmalgamatorErrorOrString_free(error_or_content);
          return LuaCEmbed_send_error(LuaCEmbed_get_error_message(args));
    }

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
    LuaCEmbed_set_long_lib_prop(l,"CAMALGAMATOR_UNEXPECTED_ERROR",CAMALGAMATOR_UNEXPECTED_ERROR);
    LuaCEmbed_set_long_lib_prop(l,"CAMALGAMATOR_DONT_INCLUDE",CAMALGAMATOR_DONT_INCLUDE);
    LuaCEmbed_set_long_lib_prop(l,"CAMALGAMATOR_DONT_CHANGE",CAMALGAMATOR_DONT_CHANGE);
    LuaCEmbed_set_long_lib_prop(l,"CAMALGAMATOR_INCLUDE_ONCE",CAMALGAMATOR_INCLUDE_ONCE);
    LuaCEmbed_set_long_lib_prop(l,"CAMALGAMATOR_INCLUDE_PERPETUAL",CAMALGAMATOR_INCLUDE_PERPETUAL);

    LuaCEmbed_add_callback(l,"generate_amalgamation_simple",private_lua_c_amalgamator_generate_amalgamation_simple);
    LuaCEmbed_add_callback(l,"generate_amalgamation_complex",private_lua_c_amalgamator_generate_amalgamation_complex);
    return LuaCembed_send_self_as_lib(l);
}
