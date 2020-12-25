fx_version 'cerulean'
game 'gta5'

author 'Calibrated | Remake by ikova'
version '2.0.0'
description 'Simple show information with commands'

client_script {
    '@es_extended/locale.lua',
    'locales/en.lua',
    'locales/pt.lua',
    'client/main.lua',
	'config.lua',
}
server_script	{
    '@es_extended/locale.lua',
    'locales/en.lua',
    'locales/pt.lua',
    'server/main.lua',
	'config.lua',
}
