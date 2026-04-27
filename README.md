# legends_cases

Item case opener with a React NUI roulette reel.

## Install

1. Download the latest `legends_cases.zip` from the [Releases](../../releases) page and extract it into your `resources/` folder. The release ZIP includes the prebuilt UI in `web/dist/`, so no build step is required.
2. `ensure legends_cases` in your `server.cfg`.
3. Register the case items in your inventory (see *Adding a case* below).

> Cloning the repository directly will not include `web/dist/` — see [Building the UI](#building-the-ui-optional).

## Compatibility

Auto-detected on start, override in `config.lua` (`Config.Integrations.*`).

- **Framework**: `qbx_core`, `qb-core`, `es_extended`, standalone
- **Inventory**: `ox_inventory`, `qs-inventory`, `codem-inventory`, `origen_inventory`, `tgiann-inventory`, `ps-inventory`, `qb-inventory`, ESX legacy, QB legacy
- **Notify**: `ox_lib`, `okokNotify`, `qbx_core`, `qb-core`, `es_extended`

## Adding a case

1. Register the item in your inventory's items file. For `ox_inventory`, set `client = { export = 'legends_cases.openCase' }` on the case item; on QB/ESX inventories no extra wiring is needed.
2. Add the case to `Config.Cases`:
   ```lua
   ['my_case'] = {
       label = 'My Case',
       items = {
           { item = 'water',         count = 5, chance = 50.0, rarity = 'milspec' },
           { item = 'WEAPON_PISTOL', count = 1, chance =  1.0, rarity = 'gold'    },
       },
   }
   ```
3. `restart legends_cases`.

## Notes

- QBox is expected to use `ox_inventory`. Other inventories work on QBox only if their exports don't depend on a qb-core player object (qs-inventory, codem-inventory work; qb-inventory does not).
- Chance values are weights, not percentages; they don't need to sum to 100.

## Building the UI

Required when cloning the repo, or if you want to modify the React NUI under `web/src/`. Skip if you installed from the release ZIP.

```sh
cd web
npm install
npm run build
```

This produces `web/dist/`, which `fxmanifest.lua` serves as the NUI. Restart the resource to pick up a new bundle.
