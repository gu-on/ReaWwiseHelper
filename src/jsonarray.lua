---@class JsonArray : Object
---@field id AK_Array
---@operator call: JsonArray
JsonArray = Object:extend()

function JsonArray:new(...)
    if ... == nil then
        self.id = reaper.AK_AkJson_Array()
        return
    end

    if type(...) == "userdata" then
        self.id = ...
        return
    end

    self.id = reaper.AK_AkJson_Array()

    if type(...) == "table" then
        for _, value in pairs(...) do
            self:Add(value)
        end
    else
        self:Add(...)
    end
end

function JsonArray:__tostring()
    return "JsonArray"
end

---Automatically converts to correct AkVariant type
---@param entry any
function JsonArray:Add(entry)
    local switch <const> = {
        ['string'] = function() return reaper.AK_AkVariant_String(entry) end,
        ['number'] = function()
            return
                math.tointeger(entry) and
                reaper.AK_AkVariant_Int(entry) or
                reaper.AK_AkVariant_Double(entry)
        end,
        ['boolean'] = function() return reaper.AK_AkVariant_Bool(entry) end,
        ['default'] = function() return nil end
    }

    local var = (switch[type(entry)] or switch['default'])()
    if var then
        reaper.AK_AkJson_Array_Add(self.id, var)
    end
end

---@param index integer
---@return AK_Array|AK_Map|AK_Variant
function JsonArray:Get(index)
    return reaper.AK_AkJson_Array_Get(self.id, index)
end

---Gets value at index as a JsonMap
---@param index integer
---@return JsonMap
function JsonArray:GetJsonMap(index)
    return JsonMap(self:Get(index))
end

---@return integer
function JsonArray:Size()
    return reaper.AK_AkJson_Array_Size(self.id)
end

return JsonArray
