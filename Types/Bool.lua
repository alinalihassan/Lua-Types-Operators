module(...,package.seeall)

local function argCheck(var, t, argNum, funcName)
   assert(type(var) == t, "bad argument #"..argNum.." to "..funcName.." ("..t.." expected, got "..type(var)..")");
end

debug.setmetatable(true,{

--  -true == false  -false == true
__unm = function(bool)
   argCheck(bool, "boolean", 1, "boolean negation");
   return (not bool)
end

--tostring(false) == "false"
__tostring = function(bool) 
   argCheck(bool, "boolean", 1, "boolean tostring");
   return(bool == true and "true" or "false")  
end

--Preventing the change of Lua Types
__metatable = error("Protected Lua Types") 

})
