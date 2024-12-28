-- @description Wwise Delete Objects with Temp Prefix
-- @author guonaudio
-- @version 1.0
-- @changelog
--   Initial release
-- @about
--   Delete objects with "temp_" prefix

package.path = package.path .. ';' .. debug.getinfo(1).source:match("@?(.*[\\|/])") .. '../Core/?.lua'

require('reawwisehelper')

local client <close> = WaapiClient()
if client then
    local paths <const> = {
        "/Actor-Mixer Hierarchy",
        "/Interactive Music Hierarchy",
        "/Events",
        "/States",
        "/Game Parameters",
        "/Switches",
        "/Triggers",
        "/SoundBanks",
        "/Effects",
        "/Attenuations",
    }

    client:UndoGroupBegin()
    for _, path in pairs(paths) do
        for obj in client:WalkProject(path, {"id", "name"}) do
            if string.sub(obj.name, 1, 5):upper() == "TEMP_" then
                client:DeleteObject(JsonMap("object", obj.id))
            end
        end
    end
    client:UndoGroupEnd("Delete objects with \"temp_\" prefix")
end