-- @description Wwise Get Selected Objects
-- @author guonaudio
-- @version 1.0
-- @changelog
--   Initial release
-- @about
--   Gets and prints 

package.path = package.path .. ';' .. debug.getinfo(1).source:match("@?(.*[\\|/])") .. '../Core/?.lua'

require('reawwisehelper')

local client <close> = WaapiClient()
if client then
    local isValid, result = client:Call("ak.wwise.waapi.getFunctions", JsonMap())

    if isValid then
        local functions <const> = result:GetJsonArray("functions")

        for i = 0, functions:Size() - 1 do
            reaper.ShowConsoleMsg(("%s\n"):format(functions:GetString(i)))
        end
    end
end
