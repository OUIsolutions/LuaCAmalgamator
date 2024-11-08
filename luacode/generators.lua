private_lua_c_amalgamator.generate_amalgamation = function(filename, max_content_size, max_recursion)
    if not filename then
        error("no filename provided")
    end
    if not max_content_size then
        max_content_size = private_lua_c_amalgamator.ONE_MEGA * 10
    end
    if not max_recursion then
        max_recursion = 1000
    end

    return private_lua_c_amalgamator_cinterop.generate_amalgamation_simple(
        filename,
        max_recursion,
        max_content_size
    )
end
