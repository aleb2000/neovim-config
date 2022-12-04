local home = os.getenv('HOME')
local db = require('dashboard')


-- linux
db.preview_command = 'lolcat'

db.preview_command = 'cat | lolcat -h 0.45 -v 0.3 -r -b'
db.preview_file_path = home .. '/.config/nvim/static/neovim.cat'
db.preview_file_height = 11
db.preview_file_width = 70

--[[
db.custom_header = {
'                                                                    ',
'      ███████████           █████      ██                     ',
'     ███████████             █████                             ',
'     ████████████████ ███████████ ███   ███████     ',
'    ████████████████ ████████████ █████ ██████████████   ',
'   █████████████████████████████ █████ █████ ████ █████   ',
' ██████████████████████████████████ █████ █████ ████ █████  ',
'██████  ███ █████████████████ ████ █████ █████ ████ ██████ ',
'██████   ██  ███████████████   ██ █████████████████ ',
'██████   ██  ███████████████   ██ █████████████████ ',
}
]]--


db.custom_center = {
	{
		icon = '  ',
		desc = 'Recently latest session                  ',
		shortcut = '; s l',
		action ='SessionLoad'
	},
	{
		icon = '  ',
		desc = 'Recently opened files                   ',
		action =  'DashboardFindHistory',
		shortcut = '; f h'
	},
	{
		icon = '  ',
		desc = 'Find  File                              ',
		action = 'Telescope find_files find_command=rg,--hidden,--files',
		shortcut = '; f f'
	},
	{
		icon = '  ',
		desc ='File Browser                            ',
		action =  'Telescope file_browser',
		shortcut = '; f b'
	},
	{
		icon = '  ',
		desc = 'Find  word                              ',
		action = 'Telescope live_grep',
		shortcut = '; f w'
	},
	{
		icon = '  ',
		desc = 'Open Personal dotfiles                  ',
		action = 'Telescope dotfiles path=' .. home ..'/.dotfiles',
		shortcut = '; f d'
	},
}
