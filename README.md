# ReaWwise Helper
A simple library to OOP-ify the ReaWwise bindings for Lua. 

The code below is provided verbatim from the blog post [WAAPI in ReaScript Lua with ReaWwise](https://www.audiokinetic.com/en/blog/waapi-in-reascript-lua-with-reawwise/). The purpose of the script is to output the paths of several objects selected in Wwise.

```lua
if(reaper.AK_Waapi_Connect("127.0.0.1", 8080)) then
    local fieldsToReturn = reaper.AK_AkJson_Array()

    reaper.AK_AkJson_Array_Add(fieldsToReturn, reaper.AK_AkVariant_String("path"))

    local options = reaper.AK_AkJson_Map()
    reaper.AK_AkJson_Map_Set(options, "return", fieldsToReturn)

    local result = reaper.AK_Waapi_Call("ak.wwise.ui.getSelectedObjects",
      reaper.AK_AkJson_Map(), options)

    local status = reaper.AK_AkJson_GetStatus(result)

    if(status) then
      local objects = reaper.AK_AkJson_Map_Get(result, "objects")
      local numObjects = reaper.AK_AkJson_Array_Size(objects)

      for i=0, numObjects - 1 do
        local item = reaper.AK_AkJson_Array_Get(objects, i)
        local path = reaper.AK_AkJson_Map_Get(item, "path")
        local pathStr = reaper.AK_AkVariant_GetString(path)
        reaper.ShowConsoleMsg(pathStr .. "\n")
      end
    end

    reaper.AK_AkJson_ClearAll()
    reaper.AK_Waapi_Disconnect()
  end
```

Using the ReaWwise Helper library, the code can instead be condensed to the following:
```lua
local client <close> = WaapiClient()
if client then
    local returns = "path"
    local parameters = JsonMap("return", JsonArray(returns))

    local isValid, result = client:Call("ak.wwise.ui.getSelectedObjects", JsonMap(), parameters)

    if isValid then
        local objects = result:GetJsonMapTable("objects")
        for _, object in pairs(objects) do
            reaper.ShowConsoleMsg(object:GetString(returns))
        end
    end
end
```

