Bridge = Bridge or {}

local function started(name)
    return GetResourceState(name) == 'started'
end

Bridge.started = started

local function detectFramework()
    local override = (Config and Config.Integrations and Config.Integrations.Framework) or 'auto'
    if override ~= 'auto' then return override end
    if started('qbx_core')     then return 'qbox' end
    if started('qb-core')      then return 'qb' end
    if started('es_extended')  then return 'esx' end
    return 'standalone'
end

local function detectInventory()
    local override = (Config and Config.Integrations and Config.Integrations.Inventory) or 'auto'
    if override ~= 'auto' then return override end
    if started('ox_inventory')      then return 'ox_inventory' end
    if started('qs-inventory')      then return 'qs-inventory' end
    if started('codem-inventory')   then return 'codem-inventory' end
    if started('origen_inventory')  then return 'origen_inventory' end
    if started('tgiann-inventory')  then return 'tgiann-inventory' end
    if started('ps-inventory')      then return 'ps-inventory' end
    if started('qb-inventory')      then return 'qb-inventory' end
    if started('qb-core')           then return 'qb' end
    if started('es_extended')       then return 'esx' end
    return 'none'
end

local function detectNotify()
    local override = (Config and Config.Integrations and Config.Integrations.Notify) or 'auto'
    if override ~= 'auto' then return override end
    if started('ox_lib')      then return 'ox_lib' end
    if started('okokNotify')  then return 'okokNotify' end
    if started('qbx_core')    then return 'qbx' end
    if started('qb-core')     then return 'qb' end
    if started('es_extended') then return 'esx' end
    return 'standalone'
end

Bridge.framework = detectFramework()
Bridge.inventory = detectInventory()
Bridge.notify    = detectNotify()
