-- @description Wwise Get Selected Objects
-- @author guonaudio
-- @version 1.0
-- @changelog
--   Initial release
-- @about
--   Matches the first example script in https://www.audiokinetic.com/en/blog/waapi-in-reascript-lua-with-reawwise/
--   Gets selected objects in Wwise and print paths to Reaper console

package.path = package.path .. ';' .. debug.getinfo(1).source:match("@?(.*[\\|/])") .. '../Core/?.lua'

require('reawwisehelper')

local client <close> = WaapiClient()
if client then
    local returns = "path"
    local parameters = JsonMap("return", JsonArray(returns))

    local isValid, result = client:Call("ak.wwise.ui.getSelectedObjects", JsonMap(), parameters)

    if isValid then
        local objects = result:GetJsonMapTable("objects")
        for _, object in pairs(objects) do
            reaper.ShowConsoleMsg(object:GetString(returns))
        end
    end
end