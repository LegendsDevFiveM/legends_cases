fx_version 'cerulean'
game 'gta5'

name 'legends_cases'
author 'Legends Scripts'
version '1.0.0'
description 'Item case opener with React NUI'

lua54 'yes'

ui_page 'web/dist/index.html'

files {
    'web/dist/index.html',
    'web/dist/assets/*.js',
    'web/dist/assets/*.css',
    'web/dist/sounds/*.ogg',
}

shared_scripts {
    'config.lua',
    'shared/rarities.lua',
    'locales/*.lua',
    'bridge/init.lua',
    'bridge/framework.lua',
}

client_scripts {
    'bridge/notify.lua',
    'client/main.lua',
}

server_scripts {
    'bridge/inventory.lua',
    'bridge/usable.lua',
    'server/main.lua',
}
