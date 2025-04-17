-- @noindex

---@class JsonMap
---@field id AK_Map Wraps pointer
---@field keys string[] Read-only keys of currently held data
---@overload fun(): JsonMap Creates a blank array
---@overload fun(map: AK_Map): JsonMap Provides a wrapper over existing ak type
---@overload fun(key: string, value: any): JsonMap Maps value to key
---@operator call: JsonMap
JsonMap = Object:extend()

function JsonMap:new(...)
    self.keys = {}
    if ... == nil then
        self.id = reaper.AK_AkJson_Map()
        return
    end

    -- no way to check if AK type. If type is userdata, rely on real-time checks
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
---@return AK_Type
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

---Get the JsonMap at the given key
---@param key string
---@return JsonMap
function JsonMap:GetJsonMap(key)
    local var <const> = self:Get(key) ---@cast var AK_Map
    return JsonMap(var)
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
---@param value AK_Type|literal|JsonArray|JsonMap
function JsonMap:Set(key, value)
    table.insertunique(self.keys, key)

    if IsJsonType(value) then
        reaper.AK_AkJson_Map_Set(self.id, key, --[[@cast value JsonArray|JsonMap]] value.id)
        return
    end

    local switch <const> = {
        ['string'] = function() return reaper.AK_AkVariant_String( --[[@cast value string]] value) end,
        ['number'] = function()
            return math.tointeger(value) and
                reaper.AK_AkVariant_Int( --[[@cast value integer]] value) or
                reaper.AK_AkVariant_Double( --[[@cast value number]] value)
        end,
        ['boolean'] = function() return reaper.AK_AkVariant_Bool( --[[@cast value boolean]] value) end,
        ['default'] = function() return --[[@cast value AK_Variant]] value end
    }

    local var = (switch[type(value)] or switch['default'])()
    reaper.AK_AkJson_Map_Set(self.id, key, var)
end

return JsonMap
