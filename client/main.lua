local L = (Locales and Locales[Config.Locale or 'en']) or {}
local isUIOpen = false

local function closeUI()
    if not isUIOpen then return end
    isUIOpen = false
    SetNuiFocus(false, false)
    TriggerScreenblurFadeOut(400)
    SendNUIMessage({ action = 'close' })
end

local function openUI(payload)
    isUIOpen = true
    SetNuiFocus(true, true)
    TriggerScreenblurFadeIn(400)
    SendNUIMessage({ action = 'openCase', data = payload })
end

if Bridge.inventory == 'ox_inventory' then
    exports('openCase', function(_, slotInfo)
        if isUIOpen then
            Bridge.notif.Notify(L.use_blocked_busy or 'Already opening a case.', 'error')
            return
        end
        if type(slotInfo) ~= 'table' then return end

        local itemName, slot = slotInfo.name, slotInfo.slot
        if type(itemName) ~= 'string' or type(slot) ~= 'number' then return end

        if not Config.Cases[itemName] then
            Bridge.notif.Notify(L.not_configured or 'This case is not configured.', 'error')
            return
        end
        TriggerServerEvent('legends_cases:server:openCase', itemName, slot)
    end)
end

RegisterNetEvent('legends_cases:client:startSpin', openUI)

RegisterNetEvent('legends_cases:client:notify', function(msg, kind)
    Bridge.notif.Notify(msg, kind)
end)

RegisterNUICallback('finished', function(_, cb)
    cb('ok')
    TriggerServerEvent('legends_cases:server:claim')
    closeUI()
end)

RegisterNUICallback('close', function(_, cb)
    cb('ok')
    TriggerServerEvent('legends_cases:server:claim')
    closeUI()
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() and isUIOpen then
        closeUI()
    end
end)
