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
    local options = JsonMap()
    local argument = start:sub(1, 1) == "\\" and "path" or "id"
    options:Set("from", JsonMap(argument, JsonArray(start)))
    options:Set("transform", JsonArray(JsonMap("select", JsonArray("children"))))

    table.insert(properties, "path")
    local parameters = JsonMap("return", JsonArray(properties))

    local isValid, result = self:Call("ak.wwise.core.object.get", options, parameters)

    if not isValid then return nil end

    local objects = result:GetJsonMapTable("return")

    local paths = {}
    for _, object in pairs(objects) do
        table.insert(paths, object:GetString("path"))
    end

    return paths
end

---@param start string # start path or guid
---@param properties string[]|nil # properties to get
---@param types string[]|nil # object types to respond to, e.g. "Event", "Sound", etc.
function WaapiClient:WalkProject(start, properties, types)
    properties = properties or {'id', "type"}

    if not self.isConnected then
        error("Waapi client is not connected")
    end

    local result = self:WalkDepthFirst(start, properties, types)

    if not result then return end

    for _, object in pairs(result) do
        reaper.ShowConsoleMsg(("%s"):format(object))
    end
end

return WaapiClient