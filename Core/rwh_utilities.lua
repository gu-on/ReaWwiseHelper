-- @noindex

---@param list table
---@param value any
function table.contains(list, value)
    for _, v in pairs(list) do
        if v == value then
            return true
        end
    end
    return false
end

---@param list table
---@param value any
function table.insertunique(list, value)
    if not table.contains(list, value) then
        table.insert(list, value)
    end
end

---@nodiscard
function table.isempty(t)
    for _, _ in pairs(t) do
        return true
    end
    return false
end