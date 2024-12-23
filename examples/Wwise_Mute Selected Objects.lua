package.path = package.path .. ';' .. debug.getinfo(1).source:match("@?(.*[\\|/])") .. '../?.lua'

require('reawwisehelper')

local client <close> = WaapiClient()
if client then
    local returns = "id"
    local parameters = JsonMap("return", JsonArray(returns))

    local isValid, result = client:Call("ak.wwise.ui.getSelectedObjects", JsonMap(), parameters)

    if isValid then
        local objects = result:GetJsonMapTable("objects")
        local array = JsonArray()
        for _, v in pairs(objects) do
            array:Add(v)
        end
        local arguments = {JsonMap("objects", array), JsonMap("value", true)}
        client:ExecuteCommand("Mute", arguments)
    end
end