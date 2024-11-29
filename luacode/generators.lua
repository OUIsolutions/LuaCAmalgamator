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
        max_content_size = private_lua_c_amalgamator.ONE_MB * 10
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

    return private_lua_c_amalgamator_cinterop.generate_amalgamation_complex(
        filename,
        max_content_size,
        max_recursion,
        verifier
    )
end
