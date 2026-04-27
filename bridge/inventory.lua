Bridge = Bridge or {}
Bridge.inv = {}

local inv = Bridge.inventory
local fw  = Bridge.framework

local QBCore
local function getQBCore()
    if QBCore then return QBCore end
    if exports['qb-core'] and exports['qb-core'].GetCoreObject then
        QBCore = exports['qb-core']:GetCoreObject()
    end
    return QBCore
end

local function qbPlayer(src)
    if fw == 'qb' then
        return Bridge.fw.GetPlayer(src)
    end
    local qb = getQBCore()
    if qb and qb.Functions and qb.Functions.GetPlayer then
        return qb.Functions.GetPlayer(src)
    end
    return Bridge.fw.GetPlayer(src)
end

local function esxPlayer(src)
    return Bridge.fw.GetPlayer(src)
end

function Bridge.inv.GetItemCount(src, item)
    if inv == 'ox_inventory' then
        return exports.ox_inventory:GetItemCount(src, item) or 0
    elseif inv == 'qs-inventory' then
        local items = exports['qs-inventory']:GetInventory(src) or {}
        local total = 0
        for _, v in pairs(items) do
            if v and v.name == item then total = total + (v.amount or v.count or 0) end
        end
        return total
    elseif inv == 'codem-inventory' then
        return exports['codem-inventory']:GetItemsTotalAmount(src, item) or 0
    elseif inv == 'origen_inventory' then
        return exports.origen_inventory:getItemCount(src, item) or 0
    elseif inv == 'tgiann-inventory' then
        return exports['tgiann-inventory']:GetItemTotalAmount(src, item) or 0
    elseif inv == 'ps-inventory' then
        local p = qbPlayer(src); if not p then return 0 end
        local i = p.Functions and p.Functions.GetItemByName and p.Functions.GetItemByName(item)
        return (i and i.amount) or 0
    elseif inv == 'qb-inventory' or inv == 'qb' then
        local p = qbPlayer(src); if not p then return 0 end
        local i = p.Functions and p.Functions.GetItemByName and p.Functions.GetItemByName(item)
        return (i and i.amount) or 0
    elseif inv == 'esx' then
        local x = esxPlayer(src); if not x then return 0 end
        local i = x.getInventoryItem and x.getInventoryItem(item)
        return (i and i.count) or 0
    end
    return 0
end

function Bridge.inv.GetSlot(src, slot)
    if inv == 'ox_inventory' then
        return exports.ox_inventory:GetSlot(src, slot)
    end
    return nil
end

function Bridge.inv.RemoveItem(src, item, count, slot)
    count = count or 1
    if inv == 'ox_inventory' then
        return exports.ox_inventory:RemoveItem(src, item, count, nil, slot) and true or false
    elseif inv == 'qs-inventory' then
        return exports['qs-inventory']:RemoveItem(src, item, count, slot) and true or false
    elseif inv == 'codem-inventory' then
        return exports['codem-inventory']:RemoveItem(src, item, count, slot) and true or false
    elseif inv == 'origen_inventory' then
        return exports.origen_inventory:removeItem(src, item, count, nil, slot) and true or false
    elseif inv == 'tgiann-inventory' then
        return exports['tgiann-inventory']:RemoveItem(src, item, count, slot) and true or false
    elseif inv == 'ps-inventory' then
        local p = qbPlayer(src); if not p then return false end
        return p.Functions.RemoveItem(item, count, slot) and true or false
    elseif inv == 'qb-inventory' or inv == 'qb' then
        local p = qbPlayer(src); if not p then return false end
        return p.Functions.RemoveItem(item, count, slot) and true or false
    elseif inv == 'esx' then
        local x = esxPlayer(src); if not x then return false end
        x.removeInventoryItem(item, count)
        return true
    end
    return false
end

function Bridge.inv.AddItem(src, item, count, metadata)
    count = count or 1
    if inv == 'ox_inventory' then
        return exports.ox_inventory:AddItem(src, item, count, metadata) and true or false
    elseif inv == 'qs-inventory' then
        return exports['qs-inventory']:AddItem(src, item, count, nil, metadata) and true or false
    elseif inv == 'codem-inventory' then
        return exports['codem-inventory']:AddItem(src, item, count, nil, metadata) and true or false
    elseif inv == 'origen_inventory' then
        return exports.origen_inventory:addItem(src, item, count, metadata) and true or false
    elseif inv == 'tgiann-inventory' then
        return exports['tgiann-inventory']:AddItem(src, item, count, nil, metadata) and true or false
    elseif inv == 'ps-inventory' then
        local p = qbPlayer(src); if not p then return false end
        return p.Functions.AddItem(item, count, nil, metadata) and true or false
    elseif inv == 'qb-inventory' or inv == 'qb' then
        local p = qbPlayer(src); if not p then return false end
        return p.Functions.AddItem(item, count, nil, metadata) and true or false
    elseif inv == 'esx' then
        local x = esxPlayer(src); if not x then return false end
        x.addInventoryItem(item, count)
        return true
    end
    return false
end
