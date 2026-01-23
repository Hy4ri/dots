vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

vim.cmd("packadd nvim-treesitter")

-- Set parser install directory
local parser_install_dir = vim.fn.stdpath("data") .. "/site/parser"
vim.opt.runtimepath:append(parser_install_dir)

local ok, configs = pcall(require, "nvim-treesitter.configs")
if ok then
	configs.setup({
		parser_install_dir = parser_install_dir,
		-- Remove ensure_installed for faster startup
		-- Run :TSInstall <lang> manually or use auto_install
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
			-- Disable for large files
			disable = function(_, buf)
				local max_filesize = 100 * 1024 -- 100 KB
				local ok_stat, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok_stat and stats and stats.size > max_filesize then
					return true
				end
			end,
		},
		indent = { enable = true },
	})
else
	vim.api.nvim_create_autocmd("FileType", {
		callback = function()
			pcall(vim.treesitter.start)
		end,
	})
end
