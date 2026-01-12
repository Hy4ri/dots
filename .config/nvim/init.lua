---@diagnostic disable: undefined-field
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
