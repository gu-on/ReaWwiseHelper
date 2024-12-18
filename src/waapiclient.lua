---@class WaapiClient : Object
---@operator call: WaapiClient
WaapiClient = Object:extend()

---@param ip string?
---@param port integer?
---@return boolean # returns true if connection was successful
function WaapiClient:new(ip, port)
    self.ip = ip or "127.0.0.1"
    self.port = port or 8080
    self.isConnected = reaper.AK_Waapi_Connect(self.ip, self.port)

    return self.isConnected
end

function WaapiClient:Close()
    reaper.AK_AkJson_ClearAll()
    reaper.AK_Waapi_Disconnect()
end

function WaapiClient:__close()
    self:Close()
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

return WaapiClient