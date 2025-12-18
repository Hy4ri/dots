---@diagnostic disable: undefined-field
-- These modules are not loaded by lazy
require("options")
require("keymaps")
require("autocmd")
require("neovide")
require("statusline")
require("tabline")

-- Bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Initialize lazy with dynamic loading of anything in the plugins directory
require("lazy").setup("plugins", {
	change_detection = {
		enabled = true,
		notify = false,
	},
})

--  Auto-sync plugins on first install
local lockfile = vim.fn.stdpath("data") .. "/lazy/lazy-lock.json"
if vim.fn.filereadable(lockfile) == 0 then
	vim.api.nvim_create_autocmd("User", {
		pattern = "LazyDone",
		once = true,
		callback = function()
			require("lazy").sync()
		end,
	})
end

vim.cmd.colorscheme("ashen")
