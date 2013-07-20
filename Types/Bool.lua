module(...,package.seeall)

local function argCheck(var, t, argNum, funcName)
   assert(type(var) == t, "bad argument #"..argNum.." to "..funcName.." ("..t.." expected, got "..type(var)..")");
end

debug.setmetatable(true,{

__unm = function(bool)
   argCheck(bool, "boolean", 1, "boolean negation");
   return (not bool)
end


})
