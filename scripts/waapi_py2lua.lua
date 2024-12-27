-- @noindex

package.path = package.path .. ';' .. debug.getinfo(1).source:match("@?(.*[\\|/])") .. '?.lua'
local argparse = require "argparse"

local parser = argparse("WAAPI Python to Lua", "Converts waapi_uri.py provided in Wwise SDK to a file that can be used by Lua Language Server")
parser:argument("input", "Input file (waapi_uri.py)")
parser:option("-o --output", "Output file.", "waapi_uri.lua")
local args = parser:parse()

local pathIn = args.input
local pathOut = args.output

---@class api_info
---@field func string # name of waapi function call
---@field desc string # tooltip for what the function does

do
    local fileIn <close> = io.open(pathIn, "r")

    if not fileIn then
        error(string.format("%s doesn't exist", pathIn))
    end

    ---@type api_info[]
    local output = {}

    local index = 1
    local prevWasDesc = false

    -- Separate lines into func and desc strings
    for line in fileIn:lines() do ---@cast line string
        if line:find("#") then
            if not prevWasDesc then
                table.insert(output, {})
                output[index].desc = line
            else
                output[index].desc = output[index].desc .. line
            end
            prevWasDesc = true
        elseif prevWasDesc then
            output[index].func = line

            prevWasDesc = false
            index = index + 1
        end
    end

    -- clean up func and desc strings
    for i, info in ipairs(output) do
        do -- grab only the api string from func
            local startPos = info.func:find("\"")
            if startPos then
                local endPos = info.func:find("\"", startPos + 1)
                assert(endPos, "Quotes must be in pairs")

                output[i].func = info.func:sub(startPos + 1, endPos - 1)
            end
        end

        do -- remove starting white space
            output[i].desc = info.desc:gsub("^%s+", "")
        end
        do -- replace multi-spaces with single-space
            output[i].desc = info.desc:gsub("%s+", " ")
        end
        do -- Make deprecation warning clearer
            output[i].desc = info.desc:gsub("# \\deprecated", "DEPRECATED")
        end
        do -- remove <tt> tags
            output[i].desc = info.desc:gsub("<tt>", "")
            output[i].desc = info.desc:gsub("</tt>", "")
        end
        do -- remove \ref
            output[i].desc = info.desc:gsub("\\ref ", "")
        end
        do -- correct space after fullstop
            output[i].desc = info.desc:gsub("%s+%.", ".")
        end
    end

    -- output 
    local file_out <close> = io.open(pathOut, "w")  -- Open file in write mode

    if not file_out then
        error("Could not open file for writing: " .. pathOut)
    end

    file_out:write("---@alias waapi_uri\n")
    for i, info in ipairs(output) do
        local line = string.format("---| \"%s\" %s", info.func, info.desc)
        line = i == #output and line .. "" or line .. "\n" -- prevent newline at eof
        file_out:write(line)
    end
end