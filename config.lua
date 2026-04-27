Config = {}

Config.SpinDuration = 6500
Config.RevealDelay  = 600
Config.WinModalTime = 4000

Config.OpenCooldown = 1500

Config.ReelLength   = 60
Config.ReelWinIndex = 55

Config.Locale = 'en'

-- See README for valid overrides.
Config.Integrations = {
    Framework = 'auto',
    Inventory = 'auto',
    Notify    = 'auto',
}

Config.Cases = {
    ['starter_case'] = {
        label = 'Starter Case',
        items = {
            { item = 'bandage',        count = 5, chance = 35.0, rarity = 'milspec'    },
            { item = 'lockpick',       count = 2, chance = 25.0, rarity = 'milspec'    },
            { item = 'radio',          count = 1, chance = 18.0, rarity = 'restricted' },
            { item = 'phone',          count = 1, chance =  6.0, rarity = 'classified' },
            { item = 'WEAPON_STUNGUN', count = 1, chance =  3.0, rarity = 'covert'     },
            { item = 'WEAPON_PISTOL',  count = 1, chance =  0.9, rarity = 'gold'       },
        },
    },
    -- To Create new cases, copy the above and change the name and contents. Then add a new item in qb-core/shared/items.lua or esx_datastore/items.lua with the same name as the case, so it can be given to players.
}
