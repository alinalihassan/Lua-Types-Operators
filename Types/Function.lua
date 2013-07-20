module(...,package.seeall)

local function argCheck(var, t, argNum, funcName)
   assert(type(var) == t, "bad argument #"..argNum.." to "..funcName.." ("..t.." expected, got "..type(var)..")");
end

debug.setmetatable(function() end,{

--Preventing the change of Lua Types
__metatable = error("Protected Lua Types")

})
