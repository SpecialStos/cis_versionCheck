fx_version 'adamant'
game 'gta5'

name "Cisoko Testing"
description "Cisoko's Testing Script"
author "Cisoko"
version "1.0.1"
lua54 'yes'

client_scripts {
    "client/mainLoop.lua",
    "configs/config.lua",
}

server_scripts {
    "server/mainLoop.lua",
    "configs/config.lua",
}

ui_page "client/html/index.html"

files {
    "client/html/index.html",
}