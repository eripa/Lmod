--------------------------------------------------------------------------
-- Lmod License
--------------------------------------------------------------------------
--
--  Lmod is licensed under the terms of the MIT license reproduced below.
--  This means that Lua is free software and can be used for both academic
--  and commercial purposes at absolutely no cost.
--
--  ----------------------------------------------------------------------
--
--  Copyright (C) 2008-2013 Robert McLay
--
--  Permission is hereby granted, free of charge, to any person obtaining
--  a copy of this software and associated documentation files (the
--  "Software"), to deal in the Software without restriction, including
--  without limitation the rights to use, copy, modify, merge, publish,
--  distribute, sublicense, and/or sell copies of the Software, and to
--  permit persons to whom the Software is furnished to do so, subject
--  to the following conditions:
--
--  The above copyright notice and this permission notice shall be
--  included in all copies or substantial portions of the Software.
--
--  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
--  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
--  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
--  NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
--  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
--  ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
--  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
--  THE SOFTWARE.
--
--------------------------------------------------------------------------

--------------------------------------------------------------------------
-- Bash: This is a derived class from BaseShell.  This classes knows how
--       to expand the environment variable into bash syntax.


require("strict")

Bash              = inheritsFrom(BaseShell)
Bash.my_name      = "bash"

local Bash        = Bash
local Dbg         = require("Dbg")
local Var         = require("Var")
local concatTbl   = table.concat
local stdout      = io.stdout

--------------------------------------------------------------------------
-- Bash:alias(): Either define or undefine a bash shell alias.


function Bash.alias(self, k, v)
   local dbg = Dbg:dbg()
   if (v == "") then
      stdout:write("unalias ",k,";\n")
      dbg.print(   "unalias ",k,";\n")
   else
      stdout:write("alias ",k,"=\"",v,"\";\n")
      dbg.print(   "alias ",k,"=\"",v,"\";\n")
   end
end

--------------------------------------------------------------------------
-- Bash:shellFunc(): Either define or undefine a bash shell function

function Bash.shellFunc(self, k, v)
   local dbg = Dbg:dbg()
   if (v == "") then
      stdout:write("unset -f ",k,";\n")
      dbg.print(   "unset -f ",k,";\n")
   else
      stdout:write(k,"() { ",v[1],"; };\n")
      dbg.print(   k,"() { ",v[1],"; };\n")
   end
end


--------------------------------------------------------------------------
-- Bash:expandVar(): Define either a global or local variable in bash
--                   syntax

function Bash.expandVar(self, k, v, vType)
   local dbg = Dbg:dbg()
   dbg.print("Key: ", k, " type(value): ", type(v)," value: ",v,"\n")
   local lineA       = {}
   v                 = doubleQuoteEscaped(tostring(v))
   lineA[#lineA + 1] = k
   lineA[#lineA + 1] = "=\""
   lineA[#lineA + 1] = v
   lineA[#lineA + 1] = "\";\n"
   if (vType ~= "local_var") then
      lineA[#lineA + 1] = "export "
      lineA[#lineA + 1] = k
      lineA[#lineA + 1] = ";\n"
   end
   local line = concatTbl(lineA,"")
   stdout:write(line)
   dbg.print(   line)
end

--------------------------------------------------------------------------
-- Bash:unset() unset an environment variable.

function Bash.unset(self, k, vType)
   local dbg = Dbg:dbg()
   stdout:write("unset ",k,";\n")
   dbg.print(   "unset ",k,";\n")
end


return Bash
