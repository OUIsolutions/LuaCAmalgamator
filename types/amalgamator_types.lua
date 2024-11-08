---@class PrivateAmalgamator
---@field generate_amalgamation_simple fun(filename:string,max_content:number,max_recursion:number)
---@field generate_amalgamation_complex fun(filename:string,max_content:number,max_recursion:number,generator_callback:fun(include:string,path:string):"dont-include"| "dont-change" | "include-once" | "include-perpetual")



---@class Amalgamator
---@field generate_amalgamation fun(filename:string,generator_callback:fun(include:string,path:string):"dont-include"| "dont-change" | "include-once" | "include-perpetual",max_content_size:number | nil,max_recursion:number|nil)
---@field ONE_MB number
---@field ONE_BYTE number

---@type Amalgamator
private_lua_c_amalgamator = private_lua_c_amalgamator

---@type PrivateAmalgamator
private_lua_c_amalgamator_cinterop = private_lua_c_amalgamator_cinterop
