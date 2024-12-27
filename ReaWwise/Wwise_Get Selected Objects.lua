package.path = package.path .. ';' .. debug.getinfo(1).source:match("@?(.*[\\|/])") .. '/Helpers/?.lua'

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