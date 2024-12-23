package.path = package.path .. ';' .. debug.getinfo(1).source:match("@?(.*[\\|/])") .. '../?.lua'

require('reawwisehelper')

local client <close> = WaapiClient()
if client then
    for obj in client:WalkProject("\\Actor-Mixer Hierarchy\\Default Work Unit", "name", "Sound") do
        reaper.ShowConsoleMsg(("%s\n"):format(obj.name))
    end
end