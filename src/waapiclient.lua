---@class WaapiClient : Object
---@operator call: WaapiClient
WaapiClient = Object:extend()

---@param ip string?
---@param port integer?
---@param autoConnect boolean?
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

---@param start string
---@param properties any
---@param types any
---@return JsonMap[]?
function WaapiClient:WalkDepthFirst(start, properties, types)
    local options = JsonMap("waql", "\"" .. start .. "\" select children")

    table.insert(properties, "path")
    local parameters = JsonMap("return", JsonArray(properties))

    local isValid, result = self:Call("ak.wwise.core.object.get", options, parameters)

    if not isValid then return nil end

    local objects = result:GetJsonMapTable("return")
    -- reaper.ShowConsoleMsg(("%s\n"):format(#objects))

    for _, object in pairs(objects) do
        local items = {}
        for _, property in pairs(properties) do
            items[property] = object:GetString(property)
        end
        coroutine.yield(items)
        self:WalkDepthFirst(items.id, properties, types)
    end

    return nil
end

---@param start string # start path or guid
---@param properties string[]|nil # properties to get
---@param types string[]|nil # object types to respond to, e.g. "Event", "Sound", etc.
function WaapiClient:WalkProject(start, properties, types)
    properties = properties or {'id', "type"}

    if not self.isConnected then
        error("Waapi client is not connected")
    end

    local co = coroutine.create(function ()
        self:WalkDepthFirst(start, properties, types)
    end)

    return function () ---@class iterator
        local _, res = coroutine.resume(co)
        return res
    end
end

return WaapiClient