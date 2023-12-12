fx_version 'adamant'
game 'gta5'

name "Cisoko Testing"
description "Cisoko's Testing Script"
author "Cisoko"
version "1.0.0"
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
    "client/html/style.css",
}

exports{
	'showUI', --Creates vins for cars. Just gives back a 17 character string with numbers. Kinda like it should look.
}