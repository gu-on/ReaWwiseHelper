-- @noindex

package.path = package.path .. ';' .. debug.getinfo(1).source:match("@?(.*[\\|/])") .. '?.lua'
local argparse = require "argparse"

local parser = argparse("WAAPI Wwise Authoring Command Identifiers URL to Lua", "Grabs data from Wwise website and converts it to a file that can be used by Lua Language Server")
parser:argument("input", "Wwise Authoring Command Identifiers (e.g. for 2024.1.5 = https://www.audiokinetic.com/en/public-library/2024.1.5_8803/?source=SDK&id=globalcommandsids.html)")
parser:option("-o --output", "Output file.", "waapi_globalcommands.lua")
-- add force command to get from web, even if file exists
local args = parser:parse()

local tempFile = "globalcommands.tmp"
local pathOut = args.output

---@class command_info
---@field func string # name of command
---@field desc string # tooltip for what the command does
---@field arg string # extra info

do
    if not io.open(tempFile, "r") then
        local suc, _, code = os.execute(string.format("curl \"%s\" -o %s", args.input, tempFile))
        if not suc then
            error(("curl command was not successful. Returned %s"):format(code))
        end
    end

    local fileIn <close> = io.open(tempFile, "r")

    if not fileIn then
        error(("file could not be opened %s"):format(tempFile))
    end

    local function contains(s, t) for _, v in pairs(t) do if s:find(v) then return true end end return false end

    local rawlines = {} ---@type string[]
    do -- get raw lines from temp file
        local shouldInsert = false
        for line in fileIn:lines() do ---@cast line string
            if shouldInsert then
                if line:find("</table>") then break end
                if line:sub(1, 3) == "<b>" then -- entries have multiline comments
                    rawlines[#rawlines -1] = rawlines[#rawlines- 1] .. line
                elseif not contains(line, {"<tr>","<th>","div"}) then -- no info in these lines
                --elseif not line:find("<tr>") and not line:find("div") and not line:find("<th>") then -- no info in these lines
                    table.insert(rawlines, line)
                end
            elseif line:find("Wwise Authoring Command Identifiers ") then
                shouldInsert = true
            end
        end
    end

    ---@type command_info[]
    local output = {}
    do -- split rawlines into func and desc
        for _, line in pairs(rawlines) do
            table.insert(output, {})
            local tagStart = "<td>"
            local tagEnd = "</td>"

            local marker = 0
            do -- Get func
                output[#output].func = ""
                local startPos = line:find(tagStart)
                if startPos then
                    local endPos = line:find(tagEnd, startPos + 1)
                    assert(endPos, "Tags must be in pairs")
                    marker = endPos

                    output[#output].func = line:sub(startPos + #tagStart, endPos - 1)
                end
            end

            assert(marker ~= nil and marker ~= 0,
                ("Line must contain two sets of strings enclosed in tags %s"):format(line))

            do -- Get desc
                output[#output].desc = ""
                local startPos = line:find(tagStart, marker)
                if startPos then
                    local endPos = line:find(tagEnd, startPos + 1)
                    assert(endPos, "Tags must be in pairs")

                    output[#output].desc = "# " .. line:sub(startPos + #tagStart, endPos - 1)
                    output[#output].desc = output[#output].desc:gsub("&amp;", "&") -- fix for Q&A
                end
            end

            do -- todo: Get arg (if exists)
                
            end
        end
    end

    -- output 
    local file_out <close> = io.open(pathOut, "w")  -- Open file in write mode

    if not file_out then
        error("Could not open file for writing: " .. pathOut)
    end

    file_out:write("-- @noindex\n")
    file_out:write("\n")
    file_out:write("---@alias WwiseAuthoringCommandIdentifiers\n")
    for i, info in ipairs(output) do
        local line = string.format("---| \"%s\" %s", info.func, info.desc)
        line = i == #output and line .. "" or line .. "\n" -- prevent newline at eof
        file_out:write(line)
    end
end