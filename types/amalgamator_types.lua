---@class PrivateAmalgamator
---@field generate_amalgamation_simple fun(filename:string,max_content:number,max_recursion:number)
---@field generate_amalgamation_complex fun(filename:string,max_content:number,max_recursion:number,generator_callback:fun(include:string,path:string):"dont-include"| "dont-change" | "include-once" | "include-perpetual"):string



---@class Amalgamator
---@field generate_amalgamation fun(filename:string, max_content_size:number | nil,max_recursion:number|nil):string
---@field generate_amalgamation_verifier fun(filename:string,verifier_callback:fun(include:string,path:string):"dont-include"|"dont-change"|"include-once"|"include-perpetual", max_content_size:number|nil,max_recursion:number|nil):string
---@field ONE_MB number
---@field ONE_BYTE number

---@type Amalgamator
private_lua_c_amalgamator = private_lua_c_amalgamator

---@type PrivateAmalgamator
public_lua_c_amalgamator = public_lua_c_amalgamator
