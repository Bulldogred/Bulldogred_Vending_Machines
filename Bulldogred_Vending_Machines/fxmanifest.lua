fx_version 'cerulean'
game 'gta5'

author 'Dhycee'
description 'Vending Machine Script with ox_target and ox_inventory integration'
version '1.0.0'

lua54 'yes'

escrow_ignore {
    'client.lua'
}

shared_script '@ox_lib/init.lua' -- Required if using ox_lib for menus
client_script 'client.lua'
server_script 'server.lua'