public_lua_c_amalgamator.generate_amalgamation = function(filename, max_content_size, max_recursion)
    if not filename then
        error("no filename provided")
    end

    if not max_content_size then
        max_content_size = public_lua_c_amalgamator.ONE_MB * 10
    end
    if type(max_content_size) ~= "number" then
        error("max content its not a number")
    end


    if not max_recursion then
        max_recursion = 1000
    end

    if type(max_recursion) ~= "number" then
        error("max recursion its not a number")
    end

    return private_lua_c_amalgamator_cinterop.generate_amalgamation_simple(
        filename,
        max_content_size,
        max_recursion
    )
end

public_lua_c_amalgamator.generate_amalgamation_with_callback = function(filename, verifier_callback, max_content_size,
                                                                        max_recursion)
    if not filename then
        error("no filename provided")
    end
    if type(verifier_callback) ~= "function" then
        error("verifier its not a function")
    end

    if not max_content_size then
        max_content_size = public_lua_c_amalgamator.ONE_MB * 10
    end
    if type(max_content_size) ~= "number" then
        error("max content its not a number")
    end


    if not max_recursion then
        max_recursion = 1000
    end

    if type(max_recursion) ~= "number" then
        error("max recursion its not a number")
    end
    function veriifier_formmated(import, path)
        local str_result = verifier_callback(import, path)
        if str_result == "dont-include" then
            return private_lua_c_amalgamator_cinterop.CAMALGAMATOR_DONT_INCLUDE
        end
        if str_result == "dont-change" then
            return private_lua_c_amalgamator_cinterop.CAMALGAMATOR_DONT_CHANGE
        end
        if str_result == "include-once" then
            return private_lua_c_amalgamator_cinterop.CAMALGAMATOR_INCLUDE_ONCE
        end
        if str_result == "include-perpetual" then
            return private_lua_c_amalgamator_cinterop.CAMALGAMATOR_INCLUDE_PERPETUAL
        end
        error("result not in ['dont-include','dont-change','include-once','include-perpetual']")
    end

    return private_lua_c_amalgamator_cinterop.generate_amalgamation_complex(
        filename,
        max_content_size,
        max_recursion,
        veriifier_formmated
    )
end
