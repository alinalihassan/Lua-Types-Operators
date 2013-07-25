module(...,package.seeall)


local function argCheck(var, t, argNum, funcName)
   assert(type(var) == t, "bad argument #"..argNum.." to "..funcName.." ("..t.." expected, got "..type(var)..")");
end


--[[Strings
============]]
debug.setmetatable("", { __add, __sub, __mul,__div,__unm,__call,__mod,__pairs,__ipairs,__index,__metatable = nil })


-- Concatenation: s1 + s2 = s1..s2
debug.getmetatable("").__add = function (s1, s2)
   argCheck(s1, "string", 1, "string addition");
   argCheck(s2, "string", 2, "string addition");
   return tostring(s1)..tostring(s2);
end

-- Gsub: s1 - s2 = s1:gsub(s2, "");
debug.getmetatable("").__sub = function (s1, s2)
   argCheck(s1, "string", 1, "string subtraction");
   argCheck(s2, "string", 2, "string subtraction");
   return string.gsub(tostring(s1), tostring(s2), "");
end

-- Repititon: "x" * y = ("x"):rep(y);
-- If y is negative then reverses string
-- "Hello" * -2 = "olleHolleH"
debug.getmetatable("").__mul = function (s, t)
   if type(s)== "string" and type(t)== "number" then
      argCheck(s, "string", 1, "string multiplication");
      argCheck(t, "number", 2, "string multiplication");
      s = s
      t = tonumber(t);
   elseif type(t) == "string" and type(s)== "number" then
      argCheck(t, "string", 1, "string multiplication");
      argCheck(s, "number", 2, "string multiplication");
      newt = t
      t = s
      s = newt
   end
   local s2 = tostring(s):rep(math.abs(t));
   if (t < 0) then
      s2 = s2:reverse();
   end
   return tostring(s2);
end

-- Split into a table: "Hello World" / " " = {"Hello", "World"}
debug.getmetatable("").__div = function (str, split)
   argCheck(str, "string", 1, "string division");
   argCheck(split, "string", 2, "string division");
   local tbl = { };
   str = tostring(str)..tostring(split);
   for s in str:gmatch("(.-)"..split) do
     tbl[#tbl + 1] = s;
   end
   return tbl;
end

-- Reverses: -"Hello" = "olleH"
debug.getmetatable("").__unm = function (str)
   argCheck(str, "string", 1, "string negation");
   return tostring(str) * -1;
end

-- String slicing (like Python):
-- stringVariable("start:finish:increment")
-- or stringVariable{"start:finish:increment"}
-- Or normal string.sub calling without increment
debug.getmetatable("").__call = function (str, ...)
   argCheck(str, "string", 1, "string slicing call");
   str = tostring(str);
   local slices = {...};
   if type(table.unpack(slices)) == "table" then slices = table.unpack(slices) end
   local doSlicing = function (start, finish, inc)
      if (inc == 1) then
         return str:sub(start, finish);
      else
         if (inc < 0) then
            start, finish = finish, start;
         end
         local s = "";
         for i = start, finish, inc do
           s = s..str:sub(i, i);
        end
        return s;
      end
   end
   if (#slices == 1) then
      if (type(slices[1]) == "number") then
         return str:sub(slices[1], slices[1]);
      elseif (type(slices[1]) == "string") then
         local start, finish, inc = slices[1]:match("(%-?%d*):?(%-?%d*):?(%-?%d*)");
         return doSlicing((start == "") and 1 or tonumber(start),
         (finish == "") and #str or tonumber(finish),
         (inc == "") and 1 or tonumber(inc));
      end
   elseif (#slices == 2) then
      return str:sub(slices[1], slices[2]);
   elseif (#slices == 3) then
      return doSlicing(unpack(slices));
   end
end

-- "My string is %lol" % {lol = "yay"}
debug.getmetatable("").__mod = function (str, tbl)
   argCheck(str, "string", 1, "string interpolation");
   argCheck(tbl, "table", 2, "string interpolation");
   return tostring(str):gsub("%%([%w_]+)", function (v)
      if (tbl[v]) then
         return tbl[v];
      end
   end);
end

-- for i,v in pairs "Hello" do print(v)
--H e l l o
debug.getmetatable("").__pairs = function(str)
   argCheck(str, "string", 1, "string pairs");
   local i,n = 0,#s
   return function()
      i = i + 1
      if i <= n then
         return i,s:sub(i,i)
      end
   end
end

-- for i,v in ipairs "Hello" do print(v)
--H e l l o
debug.getmetatable("").__ipairs = function(str)
   argCheck(str, "string", 1, "string ipairs");
   local i,n = 0,#s
   return function()
      i = i + 1
      if i <= n then
         return i,s:sub(i,i)
      end
   end
end

-- a = "Hello" 
--print a[1] -- H
debug.getmetatable("").__index = function(str,i)
   argCheck(str, "number", 1, "string indexing")
   return string.sub(str,i,i) 
end

--Preventing the change of Lua Types
debug.getmetatable("").__metatable = function() 
  return nil 
end 






--[[Booleans
===========
]]

debug.setmetatable(true,{__unm,__tostring,__metatable = nil })

--  -true == false  -false == true
debug.getmetatable(true).__unm = function(bool)
   argCheck(bool, "boolean", 1, "boolean negation");
   return (not bool)
end

--tostring(false) == "false"
debug.getmetatable(true).__tostring = function(bool) 
   argCheck(bool, "boolean", 1, "boolean tostring");
   return(bool == true and "true" or "false")  
end

--Preventing the change of Lua Types
debug.getmetatable(true).__metatable = function()
	return nil 
end





--[[
Functions
========
]]

debug.setmetatable(function() end, {__metatable = nil})

--Preventing the change of Lua Types
debug.getmetatable(function() end).__metatable = function()
	return nil 
end






--[[
Nil
========
]]

debug.setmetatable(nil, {__metatable = nil})

--Preventing the change of Lua Types
debug.getmetatable(nil).__metatable = function()
	return nil 
end






--[[
Threads
========
]]

debug.setmetatable(coroutine.create(function() end), {__metatable = nil})

--Preventing the change of Lua Types
debug.getmetatable(coroutine.create(function() end)).__metatable = function()
	return nil 
end





