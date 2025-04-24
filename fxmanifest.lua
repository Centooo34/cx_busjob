fx_version 'cerulean'
game 'gta5'
lua54 "yes"
version "1.0.0"

author 'Cento'
description 'Bus job script'

shared_scripts {
    'config/config.lua',
    "@es_extended/imports.lua",
}

client_scripts {
    '@ox_lib/init.lua',
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}

dependencies {
    'ox_lib',
    'es_extended'
}
