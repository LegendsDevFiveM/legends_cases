local L = (Locales and Locales[Config.Locale or 'en']) or {}
local cooldowns = {}
local pendingRewards = {}

math.randomseed(os.time() + GetGameTimer())

local function notify(src, msg, kind)
    TriggerClientEvent('legends_cases:client:notify', src, msg, kind)
end

local function weightedPick(items)
    local total = 0.0
    for i = 1, #items do
        total = total + (items[i].chance or 0.0)
    end
    if total <= 0 then return items[1] end

    local roll = math.random() * total
    local acc = 0.0
    for i = 1, #items do
        acc = acc + (items[i].chance or 0.0)
        if roll <= acc then
            return items[i], i
        end
    end
    return items[#items], #items
end

local function buildReel(items, winner)
    local strip = {}
    for i = 1, Config.ReelLength do
        if i == Config.ReelWinIndex then
            strip[i] = winner
        else
            strip[i] = (weightedPick(items))
        end
    end
    return strip, Config.ReelWinIndex
end

local function serializeStrip(strip)
    local out = {}
    for i = 1, #strip do
        local e = strip[i]
        out[i] = {
            item   = e.item,
            count  = e.count,
            rarity = e.rarity,
        }
    end
    return out
end

local function isOnCooldown(src)
    local now = GetGameTimer()
    local last = cooldowns[src]
    if last and (now - last) < Config.OpenCooldown then
        return true
    end
    cooldowns[src] = now
    return false
end

local function startSpin(src, caseName, slot)
    local cfg = Config.Cases[caseName]
    if not cfg then
        notify(src, L.not_configured or 'This case is not configured.', 'error')
        return
    end

    if isOnCooldown(src) then
        notify(src, L.cooldown or 'Slow down.', 'error')
        return
    end

    if pendingRewards[src] then
        notify(src, L.pending_open or 'Finish your previous case first.', 'error')
        return
    end

    if Bridge.inventory == 'ox_inventory' and slot then
        local slotItem = Bridge.inv.GetSlot(src, slot)
        if not slotItem or slotItem.name ~= caseName or (slotItem.count or 0) < 1 then
            notify(src, L.case_not_found or 'Case not found.', 'error')
            return
        end
    else
        if Bridge.inv.GetItemCount(src, caseName) < 1 then
            notify(src, L.case_not_found or 'Case not found.', 'error')
            return
        end
    end

    local removed = Bridge.inv.RemoveItem(src, caseName, 1, slot)
    if not removed then
        notify(src, L.consume_failed or 'Failed to consume case.', 'error')
        return
    end

    local winner = weightedPick(cfg.items)
    local strip, winningIndex = buildReel(cfg.items, winner)

    pendingRewards[src] = {
        item  = winner.item,
        count = winner.count or 1,
    }

    TriggerClientEvent('legends_cases:client:startSpin', src, {
        caseName     = caseName,
        caseLabel    = cfg.label,
        strip        = serializeStrip(strip),
        winningIndex = winningIndex,
        winner = {
            item   = winner.item,
            count  = winner.count,
            rarity = winner.rarity,
        },
    })
end

RegisterNetEvent('legends_cases:server:openCase', function(caseName, slot)
    local src = source
    if type(caseName) ~= 'string' then return end
    if slot ~= nil and type(slot) ~= 'number' then return end
    startSpin(src, caseName, slot)
end)

RegisterNetEvent('legends_cases:server:claim', function()
    local src = source
    local pending = pendingRewards[src]
    if not pending then return end

    pendingRewards[src] = nil

    local added = Bridge.inv.AddItem(src, pending.item, pending.count)
    if not added then
        notify(src, L.inventory_full_drop or 'Inventory full, reward dropped.', 'error')
    end
end)

AddEventHandler('playerDropped', function()
    local src = source
    cooldowns[src] = nil
    pendingRewards[src] = nil
end)

CreateThread(function()
    print(('[legends_cases] framework=%s inventory=%s notify=%s'):format(
        Bridge.framework, Bridge.inventory, Bridge.notify))

    if Bridge.inventory == 'none' then
        print('[legends_cases] no supported inventory detected, cases disabled')
        return
    end

    local registered = 0
    for caseName in pairs(Config.Cases) do
        if Bridge.use.Register(caseName, function(src, slot)
            startSpin(src, caseName, slot)
        end) then
            registered = registered + 1
        end
    end

    print(('[legends_cases] %d case(s) ready'):format(registered))
end)
