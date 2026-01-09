vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })
vim.pack.add({ "https://github.com/williamboman/mason.nvim" })
vim.pack.add({ "https://github.com/williamboman/mason-lspconfig.nvim" })
vim.pack.add({ "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" })
vim.pack.add({ "https://github.com/saghen/blink.cmp" })

require("mason").setup()

require("mason-tool-installer").setup({
	ensure_installed = { "lua_ls" },
})

local capabilities = require("blink.cmp").get_lsp_capabilities()

-- Servers configuration
local servers = {
	lua_ls = {
		settings = {
			Lua = {
				completion = { callSnippet = "Replace" },
			},
		},
	},
	nixd = {},
	ty = {},
}

-- Mason LSPConfig
require("mason-lspconfig").setup({
	handlers = {
		function(server_name)
			local opts = vim.tbl_deep_extend("force", {
				capabilities = capabilities,
			}, servers[server_name] or {})

			require("lspconfig")[server_name].setup(opts)
		end,
	},
})

vim.lsp.config("nixd", { capabilities = capabilities })
vim.lsp.config("ty", { capabilities = capabilities })
vim.lsp.enable("nixd")
vim.lsp.enable("ty")

-- LspAttach Autocmd
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			vim.keymap.set(mode or "n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		local client = vim.lsp.get_client_by_id(event.data.client_id)

		-- Highlight references (simplified for 0.12+)
		if client and client:supports_method("textDocument/documentHighlight") then
			local hl_group = vim.api.nvim_create_augroup("lsp_highlight_" .. event.buf, { clear = true })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = hl_group,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = hl_group,
				callback = vim.lsp.buf.clear_references,
			})
		end

		-- Inlay hints
		if client and client:supports_method("textDocument/inlayHint") then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "Toggle Inlay Hints")
		end

		map("<leader>rn", vim.lsp.buf.rename, "Rename")
		map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
		map("]d", function()
			vim.diagnostic.jump({ count = 1 })
		end, "Next Diagnostic")
		map("[d", function()
			vim.diagnostic.jump({ count = -1 })
		end, "Previous Diagnostic")
	end,
})

-- Diagnostic Config
vim.diagnostic.config({
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = vim.diagnostic.severity.ERROR },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
	},
	virtual_text = {
		source = "if_many",
		spacing = 2,
		format = function(d)
			return d.message
		end,
	},
	update_in_insert = false,
})
