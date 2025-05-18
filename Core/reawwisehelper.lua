-- @description ReaWwiseHelper
-- @author guonaudio
-- @version 0.2.3
-- @provides 
--   [nomain] .
--   [nomain] rwh_classic.lua
--   [nomain] rwh_waapiclient.lua
--   [nomain] rwh_jsonarray.lua
--   [nomain] rwh_jsonmap.lua
--   [nomain] rwh_utilities.lua
--   [nomain] waapi_uri.lua
--   [nomain] waapi_globalcommands.lua
-- @changelog
--   Fixed some Lua Language Server warnings
--   Added uri and globalcommands to be downloaded by ReaPack
-- @about
--   Main library for handling all other required libraries

---@class iterator # 

if not reaper.APIExists("AK_Waapi_Connect") then
    error("ReaWwise missing. Please install via ReaPack -> https://github.com/audiokinetic/ReaWwise?tab=readme-ov-file#installing-reawwise-through-reapack")
end

package.path = package.path .. ';' .. debug.getinfo(1).source:match("@?(.*[\\|/])") .. '?.lua'

Object = require('rwh_classic')
Utilities = require('rwh_utilities')
WaapiClient = require('rwh_waapiclient')
JsonArray = require('rwh_jsonarray')
JsonMap = require('rwh_jsonmap')