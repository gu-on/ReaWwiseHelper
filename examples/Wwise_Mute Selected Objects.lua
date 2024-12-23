package.path = package.path .. ';' .. debug.getinfo(1).source:match("@?(.*[\\|/])") .. '../?.lua'

require('reawwisehelper')

local client <close> = WaapiClient()
if client then
    local parameters = JsonMap("return", JsonArray("id"))
    local isValid, result = client:Call("ak.wwise.ui.getSelectedObjects", JsonMap(), parameters)

    if isValid then
        local objects = result:GetJsonMapTable("objects")
        local arguments = {JsonMap("objects", JsonArray(objects)), JsonMap("value", true)}
        client:ExecuteCommand("Mute", arguments)
    end
end