---@class WaapiClient : Object
---@operator call: WaapiClient
WaapiClient = Object:extend()

---@param ip string?
---@param port integer?
---@param autoConnect boolean? # if nil, will connect automatically
---@return boolean # returns true if connection was successful
function WaapiClient:new(ip, port, autoConnect)
    self.ip = ip or "127.0.0.1"
    self.port = port or 8080
    autoConnect = autoConnect or true
    self.isConnected = autoConnect and self:Connect()

    return self.isConnected
end

function WaapiClient:__close()
    self:Close()
end

function WaapiClient:Connect()
    return reaper.AK_Waapi_Connect(self.ip, self.port)
end

function WaapiClient:Clear()
    reaper.AK_AkJson_ClearAll()
end

function WaapiClient:Close()
    self:Clear()
    reaper.AK_Waapi_Disconnect()
end

---@param command waapi_uri # commands
---@param options JsonMap # arguments
---@param parameters JsonMap # options
---@return boolean, JsonMap
function WaapiClient:Call(command, options, parameters)
    local result = JsonMap(reaper.AK_Waapi_Call(command, options.id, parameters.id))
    local status = reaper.AK_AkJson_GetStatus(result.id)
    return status, result
end

---@private
---@param start string # Path or id
---@param properties string[]
---@param types string[]
---@return JsonMap[]?
function WaapiClient:WalkDepthFirst(start, properties, types)
    local options <const> = JsonMap("waql", "\"" .. start .. "\" select children")
    local parameters <const> = JsonMap("return", JsonArray(properties))

    local isValid <const>, result <const> = self:Call("ak.wwise.core.object.get", options, parameters)

    if not isValid then return nil end

    for _, object in pairs(result:GetJsonMapTable("return")) do
        local items = {}
        for _, property in pairs(properties) do
            items[property] = object:GetString(property)
        end
        if table.isempty(types) --[[not specified, so get all]] or table.contains(types, items.type) then
            coroutine.yield(items)
        end
        self:WalkDepthFirst(items.id, properties, types)
    end
end

---@param start string # start path or guid
---@param properties string|string[]|nil # properties to get
---@param types string|string[]|nil # object types to respond to, e.g. "Event", "Sound", etc.
---@return iterator
function WaapiClient:WalkProject(start, properties, types)
    if not self.isConnected then
        error("Waapi client is not connected")
    end

    do -- clean up properties
        if not properties then
            properties = {} -- ensure table
        elseif type(properties) ~= "table" then
            assert(type(properties) == "string", "If providing a single arg, only 'string' is allowed")
            properties = { properties } -- ensure table
        end

        table.insertunique(properties, "id")
        table.insertunique(properties, "type")
    end

    do -- clean up types
        if not types then
            types = {} -- ensure table
        elseif type(types) ~= "table" then
            assert(type(types) == "string", "If providing a single arg, only 'string' is allowed")
            types = { types } -- ensure table
        end
    end

    local co = coroutine.create(function() self:WalkDepthFirst(start, properties, types) end)

    return function() ---@type iterator
        return select(2, coroutine.resume(co))
    end
end

return WaapiClient
