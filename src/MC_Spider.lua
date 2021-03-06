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

require("strict")

local Dbg              = require("Dbg")
MC_Spider              = inheritsFrom(MasterControl)
MC_Spider.my_name      = "MC_Spider"

local M                = MC_Spider

M.always_load          = MasterControl.quiet
M.always_unload        = MasterControl.quiet
M.conflict             = MasterControl.quiet
M.error                = MasterControl.quiet
M.family               = MasterControl.quiet
M.inherit              = MasterControl.quiet
M.load                 = MasterControl.quiet
M.message              = MasterControl.quiet
M.prereq               = MasterControl.quiet
M.prereq_any           = MasterControl.quiet
M.pushenv              = MasterControl.quiet
M.remove_path          = MasterControl.quiet
M.report               = MasterControl.warning
M.set_alias            = MasterControl.quiet
M.set_shell_function   = MasterControl.quiet
M.try_load             = MasterControl.quiet
M.unload               = MasterControl.quiet
M.unloadsys            = MasterControl.quiet
M.unsetenv             = MasterControl.quiet
M.unset_alias          = MasterControl.quiet
M.unset_shell_function = MasterControl.quiet
M.usrload              = MasterControl.quiet
M.warning              = MasterControl.warning

function M.myFileName(self)
   local masterTbl   = masterTbl()
   local moduleStack = masterTbl.moduleStack
   local iStack      = #moduleStack
   return moduleStack[iStack].fn
end


function M.myModuleFullName(self)
   local masterTbl   = masterTbl()
   local moduleStack = masterTbl.moduleStack
   local iStack      = #moduleStack
   return moduleStack[iStack].full
end

M.myModuleUsrName = M.myModuleFullName

function M.myModuleName(self)
   local masterTbl   = masterTbl()
   local moduleStack = masterTbl.moduleStack
   local iStack      = #moduleStack
   return moduleStack[iStack].sn
end

function M.myModuleVersion(self)
   local masterTbl   = masterTbl()
   local moduleStack = masterTbl.moduleStack
   local iStack      = #moduleStack
   local full        = moduleStack[iStack].full
   local sn          = moduleStack[iStack].sn
   return extractVersion(full, sn) or ""
end

function M.help(self,...)
   local dbg    = Dbg:dbg()
   dbg.start("MC_Spider:help(...)")
   Spider_help(...)
   dbg.fini()
   return true
end

function M.whatis(self,...)
   local dbg    = Dbg:dbg()
   dbg.start("MC_Spider:whatis(...)")
   Spider_whatis(...)
   dbg.fini()
   return true
end

function M.setenv(self,...)
   local dbg    = Dbg:dbg()
   dbg.start("MC_Spider:setenv(...)")
   Spider_setenv(...)
   dbg.fini()
   return true
end

function M.prepend_path(self,...)
   local dbg    = Dbg:dbg()
   dbg.start("MC_Spider:prepend_path(...)")
   Spider_append_path("prepend",...)
   dbg.fini()
   return true

end

function M.append_path(self,...)
   local dbg    = Dbg:dbg()
   dbg.start("MC_Spider:append_path(...)")
   Spider_append_path("append",...)
   dbg.fini()
   return true
end

function M.is_spider(self)
   local dbg    = Dbg:dbg()
   dbg.start("MC_Spider:is_spider()")
   dbg.fini()
   return true
end

function M.add_property(self,...)
   local dbg    = Dbg:dbg()
   dbg.start("MC_Spider:add_property(...)")
   Spider_add_property(...)
   dbg.fini()
   return true
end

function M.remove_property(self,...)
   local dbg    = Dbg:dbg()
   dbg.start("MC_Spider:remove_property(...)")
   Spider_remove_property(...)
   dbg.fini()
   return true
end

return M
