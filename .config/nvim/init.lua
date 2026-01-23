---@diagnostic disable: undefined-field

vim.loader.enable()

vim.g.loaded_gzip = 1 -- Editing gzip compressed files
vim.g.loaded_zip = 1 -- Editing zip archives
vim.g.loaded_zipPlugin = 1 -- Zip archive browser
vim.g.loaded_tar = 1 -- Editing tar archives
vim.g.loaded_tarPlugin = 1 -- Tar archive browser
vim.g.loaded_getscript = 1 -- Downloading Vim scripts
vim.g.loaded_getscriptPlugin = 1 -- GetLatestVimScripts plugin
vim.g.loaded_vimball = 1 -- Creating/extracting vimball archives
vim.g.loaded_vimballPlugin = 1 -- Vimball archive browser
vim.g.loaded_matchit = 1 -- Extended % matching (use vim-matchup instead)
vim.g.loaded_matchparen = 1 -- Highlight matching parens (treesitter does this)
vim.g.loaded_logiPat = 1 -- Logical pattern matching
vim.g.loaded_rrhelper = 1 -- Remote reply helper
vim.g.loaded_netrw = 1 -- Built-in file explorer (using yazi instead)
vim.g.loaded_netrwPlugin = 1 -- Netrw plugin
vim.g.loaded_netrwSettings = 1 -- Netrw settings
vim.g.loaded_netrwFileHandlers = 1 -- Netrw file handlers
vim.g.loaded_tutor_mode_plugin = 1 -- Vim tutor
vim.g.loaded_rplugin = 1 -- Remote plugin framework

-- Load core configuration
require("options")
require("keymaps")
require("autocmd")
require("neovide")
require("statusline")

-- Load all plugin configurations independently
local plugins_path = vim.fn.stdpath("config") .. "/lua/plugins"
local plugins = vim.fn.readdir(plugins_path)

for _, file in ipairs(plugins) do
	if file:match("%.lua$") then
		local module_name = file:sub(1, -5)
		local ok, err = pcall(require, "plugins." .. module_name)
		if not ok then
			vim.notify("Error loading " .. module_name .. ":\n" .. err, vim.log.levels.ERROR)
		end
	end
end
