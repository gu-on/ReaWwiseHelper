-- @noindex

---@class JsonArray : Object
---@field id AK_Array # Wraps pointer
---@overload fun() : JsonArray Creates a blank array
---@overload fun(t: table) : JsonArray Automatically fills array with data provided
---@overload fun(AK_Array) : JsonArray Provides a wrapper over existing AK_Array
---@operator call : JsonArray
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
            return math.tointeger(entry) and
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
---@return AK_Type
function JsonArray:Get(index)
    return reaper.AK_AkJson_Array_Get(self.id, index)
end

---@param index integer
---@return boolean
function JsonArray:GetBool(index)
    local var <const> = self:Get(index) ---@cast var AK_Variant
    return reaper.AK_AkVariant_GetBool(var)
end

---@param index integer
---@return integer
function JsonArray:GetInt(index)
    local var <const> = self:Get(index) ---@cast var AK_Variant
    return reaper.AK_AkVariant_GetInt(var)
end

---@param index integer
---@return number
function JsonArray:GetDouble(index)
    local var <const> = self:Get(index) ---@cast var AK_Variant
    return reaper.AK_AkVariant_GetDouble(var)
end

---@param index integer
---@return string
function JsonArray:GetString(index)
    local var <const> = self:Get(index) ---@cast var AK_Variant
    return reaper.AK_AkVariant_GetString(var)
end

---Gets value at index as a JsonMap
---@param index integer
---@return JsonMap
function JsonArray:GetJsonMap(index)
    local var <const> = self:Get(index) ---@cast var AK_Map
    return JsonMap(var)
end

---@return integer
function JsonArray:Size()
    return reaper.AK_AkJson_Array_Size(self.id)
end

return JsonArray
