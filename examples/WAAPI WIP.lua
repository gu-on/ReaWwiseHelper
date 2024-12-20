package.path = package.path .. ';' .. debug.getinfo(1).source:match("@?(.*[\\|/])") .. '../?.lua'

require('reawwisehelper')

--- example: Passing in a command
-- local options = JsonMap("command", reaper.AK_AkVariant_String("Help"))
-- client:Call("ak.wwise.ui.commands.execute", options, JsonMap())

local client = WaapiClient()
if client then
    client:WalkProject("\\Actor-Mixer Hierarchy")
    -- for object in client:WalkProject("\\Actor-Mixer Hierarchy") do
    --     print(object.path)
    -- end
    client:Clear()
end