-- @noindex

---@class WaapiClient : Object
---@operator call: WaapiClient
WaapiClient = Object:extend()

---@alias AK_Type AK_Array|AK_Map|AK_Variant # Wwise-specific types
---@alias literal string|number|boolean # Lua literals
---@alias JsonType JsonArray|JsonMap # WaapiHelper Json types

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

---Connects to waapi
---@return boolean # Whether connection was successful
function WaapiClient:Connect()
    return reaper.AK_Waapi_Connect(self.ip, self.port)
end

---Disconnect from waapi
function WaapiClient:Disconnect()
    reaper.AK_Waapi_Disconnect()
end

---Clear all Wwise objects referenced by pointers
function WaapiClient:Clear()
    reaper.AK_AkJson_ClearAll()
end

function WaapiClient:Close()
    self:Clear()
    self:Disconnect()
end

---@param command string|waapi_uri # commands
---@param options JsonMap? # arguments
---@param parameters JsonMap? # options
---@return boolean, JsonMap
function WaapiClient:Call(command, options, parameters)
    options = options or JsonMap()
    parameters = parameters or JsonMap()
    local result = JsonMap(reaper.AK_Waapi_Call(command, options.id, parameters.id))
    local status = reaper.AK_AkJson_GetStatus(result.id)
    return status, result
end

---@param command string|WwiseAuthoringCommandIdentifiers
---@param arguments JsonMap|JsonMap[]|nil
function WaapiClient:ExecuteCommand(command, arguments)
    local options = JsonMap("command", command)
    if arguments then
        if type(arguments) == "table" then
            for _, argument in pairs(arguments) do
                for _, key in pairs(argument.keys) do
                    options:Set(key, argument:Get(key))
                end
            end
        else
            for _, key in pairs(arguments.keys) do
                options:Set(key, arguments:Get(key))
            end
        end
    else
        arguments = JsonMap()
    end
    self:Call("ak.wwise.ui.commands.execute", options, JsonMap())
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
---@param types string|string[]|nil # object types to respond to, e.g. "Event", "Sound", etc. If nil, gets all types
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

---@param object JsonMap
function WaapiClient:DeleteObject(object)
    self:Call("ak.wwise.core.object.delete", object)
end

function WaapiClient:UndoGroupBegin()
    self:Call("ak.wwise.core.undo.beginGroup")
end

---@param undoMessage string Message to display in Wwise after undo is performed
function WaapiClient:UndoGroupEnd(undoMessage)
    undoMessage = undoMessage or "Performed grouped WAAPI call"
    local arguments <const> = JsonMap("displayName", undoMessage)
    self:Call("ak.wwise.core.undo.endGroup", arguments)
end

function WaapiClient:Undo()
    self:ExecuteCommand("Undo")
end

function WaapiClient:Redo()
    self:ExecuteCommand("Redo")
end

return WaapiClient
