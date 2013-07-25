Lua-Types-Operators
===================
_______________________________________________________________
Module: Types Operators

Version: 1.0

Purpose: Adding operators for lua types

Author: superalin98

Date: July 2013

License: MIT License
_______________________________________________________________

Features
--------

- Under 250 lines with comments
- With this script now you can use operators for strings,booleans,threads,nil and functions
- You can costumize them for your own needs
- Less code writing
- Examples for each function in the main script


String Operators
--------

    require "Operators"
    -- Concatenation: s1 + s2 = s1..s2
    print("Hello" + " " + "World") -- Hello World
    
    -- Gsub: s1 - s2 = s1:gsub(s2, "")
    print("Hello" - "l") -- Heo
    
    -- Repititon: "x" * y = ("x"):rep(y)
    print("Hello" * -2) -- "olleHolleH"
    
    -- Split into a table:
    print("Hello World" / " ") -- {"Hello", "World"}
    
    -- Reverses:
    print(-"Hello" = "olleH")
    
    -- String slicing (like Python):
    -- stringVariable("start:finish:increment")
    -- stringVariable{"start:finish:increment"}
    x = "Hello World"
    x(1,3)
    x{1,3}
    
    --Python like string interpolation
      print("My string is %lol" % {lol = "yay"}) -- My string is yay
    
    --Pairs and Ipairs
      for i,v in pairs "Hello" do print(i,v) end -- 1,H | 2,e | 3,l | 4,l| 5,o|
      for i,v in ipairs "Hello" do print(i,v) end -- 1,H | 2,e | 3,l | 4,l| 5,o|

    --Indexing
      a = "Hello World" print(a[1]) -- H
      
      
Bool Operators
--------

    require "Operators"
    --Negation: -bool = not bool
    print(-true) -- false
    
    


