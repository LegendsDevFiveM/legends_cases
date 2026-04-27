Bridge = Bridge or {}
Bridge.use = {}

local fw  = Bridge.framework
local inv = Bridge.inventory

local function started(name)
    return GetResourceState(name) == 'started'
end

local function tryQB(itemName, handler)
    if not started('qb-core') then return false end
    local QBCore = exports['qb-core']:GetCoreObject()
    if not (QBCore and QBCore.Functions and QBCore.Functions.CreateUseableItem) then return false end
    QBCore.Functions.CreateUseableItem(itemName, function(source, item)
        handler(source, item and item.slot)
    end)
    return true
end

local function tryQBX(itemName, handler)
    if not started('qbx_core') then return false end
    if not (exports.qbx_core and exports.qbx_core.CreateUseableItem) then return false end
    exports.qbx_core:CreateUseableItem(itemName, function(source, item)
        handler(source, item and item.slot)
    end)
    return true
end

local function tryESX(itemName, handler)
    if not started('es_extended') then return false end
    local ESX
    if exports['es_extended'] and exports['es_extended'].getSharedObject then
        ESX = exports['es_extended']:getSharedObject()
    else
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
    if not (ESX and ESX.RegisterUsableItem) then return false end
    ESX.RegisterUsableItem(itemName, function(source)
        handler(source, nil)
    end)
    return true
end

function Bridge.use.Register(itemName, handler)
    if inv == 'ox_inventory' then
        return 'ox_inventory_client_export'
    end

    if inv == 'qs-inventory' and started('qs-inventory') and exports['qs-inventory'].CreateUseableItem then
        exports['qs-inventory']:CreateUseableItem(itemName, function(source)
            handler(source, nil)
        end)
        return 'qs-inventory'
    end

    if inv == 'codem-inventory' and started('codem-inventory') and exports['codem-inventory'].CreateUseableItem then
        exports['codem-inventory']:CreateUseableItem(itemName, function(source, item)
            handler(source, item and item.slot)
        end)
        return 'codem-inventory'
    end

    if fw == 'qbox' then
        if tryQBX(itemName, handler) then return 'qbx_core' end
        if tryQB(itemName, handler)  then return 'qb-core' end
    end

    if fw == 'qb' then
        if tryQB(itemName, handler) then return 'qb-core' end
    end

    if fw == 'esx' then
        if tryESX(itemName, handler) then return 'es_extended' end
    end

    return nil
end
