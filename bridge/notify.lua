Bridge = Bridge or {}
Bridge.notif = {}

local mode = Bridge.notify
local QBCore, ESX

local function getQB()
    if QBCore then return QBCore end
    if exports['qb-core'] and exports['qb-core'].GetCoreObject then
        QBCore = exports['qb-core']:GetCoreObject()
    end
    return QBCore
end

local function getESX()
    if ESX then return ESX end
    if exports['es_extended'] and exports['es_extended'].getSharedObject then
        ESX = exports['es_extended']:getSharedObject()
    else
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
    return ESX
end

function Bridge.notif.Notify(msg, kind)
    kind = kind or 'inform'
    if mode == 'ox_lib' then
        exports.ox_lib:notify({ type = kind, description = msg })
    elseif mode == 'okokNotify' then
        local title = (kind == 'error' and 'Error') or (kind == 'success' and 'Success') or 'Info'
        exports['okokNotify']:Alert(title, msg, 4000, kind)
    elseif mode == 'qbx' then
        if exports.qbx_core and exports.qbx_core.Notify then
            exports.qbx_core:Notify(msg, kind, 4000)
        end
    elseif mode == 'qb' then
        local qb = getQB()
        if qb and qb.Functions and qb.Functions.Notify then
            qb.Functions.Notify(msg, kind, 4000)
        end
    elseif mode == 'esx' then
        local esx = getESX()
        if esx and esx.ShowNotification then esx.ShowNotification(msg) end
    else
        BeginTextCommandThefeedPost('STRING')
        AddTextComponentSubstringPlayerName(msg)
        EndTextCommandThefeedPostTicker(false, false)
    end
end
