package.path = package.path .. ';' .. debug.getinfo(1).source:match("@?(.*[\\|/])") .. '../?.lua'

require('reawwisehelper')

--- example: Passing in a command
-- local options = JsonMap("command", reaper.AK_AkVariant_String("Help"))
-- client:Call("ak.wwise.ui.commands.execute", options, JsonMap())

local client <close> = WaapiClient()
if client then
    for obj in client:WalkProject("\\Actor-Mixer Hierarchy\\Default Work Unit") do
        reaper.ShowConsoleMsg(("%s\n"):format(obj.path))
    end
end