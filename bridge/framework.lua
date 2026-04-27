Bridge = Bridge or {}
Bridge.fw = {}

local fw = Bridge.framework
local QBCore, ESX

if fw == 'qb' then
    QBCore = exports['qb-core']:GetCoreObject()
elseif fw == 'esx' then
    if exports['es_extended'] and exports['es_extended'].getSharedObject then
        ESX = exports['es_extended']:getSharedObject()
    else
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
end

function Bridge.fw.GetCore()
    if fw == 'qb' or fw == 'qbox' then return QBCore end
    if fw == 'esx' then return ESX end
end

function Bridge.fw.GetPlayer(src)
    if fw == 'qbox' then
        return exports.qbx_core:GetPlayer(src)
    elseif fw == 'qb' and QBCore then
        return QBCore.Functions.GetPlayer(src)
    elseif fw == 'esx' and ESX then
        return ESX.GetPlayerFromId(src)
    end
end
