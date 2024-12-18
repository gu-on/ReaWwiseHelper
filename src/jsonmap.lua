---@class JsonMap
---@field id AK_Map
---@operator call: JsonMap
JsonMap = Object:extend()

---@param ... nil|[string, string]|AK_Array|AK_Map|AK_Variant
function JsonMap:new(...)
    if ... == nil then
        self.id = reaper.AK_AkJson_Map()
        return
    end

    if type(...) == "userdata" then
        self.id = select(1, ...)
        return
    end

    self.id = reaper.AK_AkJson_Map()

    self:Set(select(1, ...), select(2, ...))
end

function JsonMap:__tostring()
    return "JsonMap"
end

---@param key string
---@return AK_Array|AK_Map|AK_Variant
function JsonMap:Get(key)
    return reaper.AK_AkJson_Map_Get(self.id, key)
end

---@param key string
---@return JsonArray
function JsonMap:GetJsonArray(key) return JsonArray(self:Get(key)) end

---@param key string
---@return JsonMap[]
function JsonMap:GetJsonMapTable(key)
    local t = {} ---@type JsonMap[]
    local objects = self:GetJsonArray(key)
    for i = 0, objects:Size() - 1 do
        table.insert(t, objects:GetJsonMap(i))
    end
    return t
end

---@param key string
---@return JsonMap
function JsonMap:GetJsonMap(key)
    return JsonMap(self:Get(key))
end

---@param key string
---@return boolean
function JsonMap:GetBool(key)
    local var <const> = self:Get(key) ---@cast var AK_Variant
    return reaper.AK_AkVariant_GetBool(var)
end

---@param key string
---@return integer
function JsonMap:GetInt(key)
    local var <const> = self:Get(key) ---@cast var AK_Variant
    return reaper.AK_AkVariant_GetInt(var)
end

---@param key string
---@return number
function JsonMap:GetDouble(key)
    local var <const> = self:Get(key) ---@cast var AK_Variant
    return reaper.AK_AkVariant_GetDouble(var)
end

---@param key string
---@return string
function JsonMap:GetString(key)
    local var <const> = self:Get(key) ---@cast var AK_Variant
    return reaper.AK_AkVariant_GetString(var)
end

---@nodiscard
function IsJsonType(value)
    return type(value) == "table" and value.is ~= nil and (value:is(JsonArray) or value:is(JsonMap))
end

---@param key string
---@param value AK_Array|AK_Map|AK_Variant|JsonArray|JsonMap
function JsonMap:Set(key, value)
    if IsJsonType(value) then
        ---@cast value JsonArray|JsonMap
        reaper.AK_AkJson_Map_Set(self.id, key, value.id)
    else
        ---@cast value AK_Array|AK_Map|AK_Variant
        reaper.AK_AkJson_Map_Set(self.id, key, value)
    end
end

return JsonMap