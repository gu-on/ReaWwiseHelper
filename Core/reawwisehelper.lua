-- @description ReaWwiseHelper
-- @author guonaudio
-- @version 0.2.0
-- @provides 
--   [nomain] .
--   [nomain] rwh_classic.lua
--   [nomain] rwh_waapiclient.lua
--   [nomain] rwh_jsonarray.lua
--   [nomain] rwh_jsonmap.lua
--   [nomain] rwh_utilities.lua
-- @changelog
--   Added undo/redo to client, and ability to control undo/redo (as well as for group)
-- @about
--   Main library for handling all other required libraries

---@class iterator # 

package.path = package.path .. ';' .. debug.getinfo(1).source:match("@?(.*[\\|/])") .. '?.lua'

Object = require('rwh_classic')
Utilities = require('rwh_utilities')
WaapiClient = require('rwh_waapiclient')
JsonArray = require('rwh_jsonarray')
JsonMap = require('rwh_jsonmap')