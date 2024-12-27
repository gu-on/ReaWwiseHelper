-- @description Wwise Print Sounds in Actor-Mixer Hierarchy
-- @author guonaudio
-- @version 1.0
-- @changelog
--   Initial release
-- @about
--   Prints all Sounds under Actor-Mixer to Reaper console

package.path = package.path .. ';' .. debug.getinfo(1).source:match("@?(.*[\\|/])") .. '/Helpers/?.lua'

require('reawwisehelper')

local client <close> = WaapiClient()
if client then
    for obj in client:WalkProject("/Actor-Mixer Hierarchy", "name", "Sound") do
        reaper.ShowConsoleMsg(("%s\n"):format(obj.name))
    end
end