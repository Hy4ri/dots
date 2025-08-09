return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", opts = {} }, -- Tool/LSP installer
		"williamboman/mason-lspconfig.nvim", -- Mason ↔ LSP bridge
		"WhoIsSethDaniel/mason-tool-installer.nvim", -- Auto install tools
		"saghen/blink.cmp", -- Completion capabilities
	},
	config = function()
		-- Keymaps when an LSP server attaches to a buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					vim.keymap.set(mode or "n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				map("grn", vim.lsp.buf.rename, "Rename symbol")
				map("gra", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
				map("grr", require("telescope.builtin").lsp_references, "References")
				map("gri", require("telescope.builtin").lsp_implementations, "Implementations")
				map("grd", require("telescope.builtin").lsp_definitions, "Definitions")
				map("grD", vim.lsp.buf.declaration, "Declaration")
				map("gO", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
				map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
				map("grt", require("telescope.builtin").lsp_type_definitions, "Type Definition")

				-- Highlight symbol references
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.supports_method("textDocument/documentHighlight") then
					local hl_group = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
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
					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
						callback = function(e)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = e.buf })
						end,
					})
				end

				-- Toggle inlay hints
				if client and client.supports_method("textDocument/inlayHint") then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "Toggle Inlay Hints")
				end
			end,
		})

		-- Diagnostic UI settings
		vim.diagnostic.config({
			severity_sort = true,
			float = { border = "rounded", source = "if_many" },
			underline = { severity = vim.diagnostic.severity.ERROR },
			signs = vim.g.have_nerd_font and {
				text = {
					[vim.diagnostic.severity.ERROR] = "󰅚 ",
					[vim.diagnostic.severity.WARN] = "󰀪 ",
					[vim.diagnostic.severity.INFO] = "󰋽 ",
					[vim.diagnostic.severity.HINT] = "󰌶 ",
				},
			} or {},
			virtual_text = {
				source = "if_many",
				spacing = 2,
				format = function(d)
					return d.message
				end,
			},
		})

		-- Add completion capabilities from blink.cmp
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- LSP servers configuration
		local servers = {
			pyright = {},
			-- qmlls = { capabilities = capabilities }, -- QML language server
			lua_ls = {
				settings = {
					Lua = {
						completion = { callSnippet = "Replace" },
						-- diagnostics = { disable = { "missing-fields" } }, -- Example to disable warnings
					},
				},
			},
		}

		-- Tools to install via Mason
		local ensure_installed = vim.tbl_keys(servers)
		vim.list_extend(ensure_installed, { "stylua" }) -- Formatter for Lua
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		-- Setup LSP servers with capabilities
		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local opts = vim.tbl_deep_extend(
						"force",
						{},
						{ capabilities = capabilities },
						servers[server_name] or {}
					)
					require("lspconfig")[server_name].setup(opts)
				end,
			},
		})
	end,
}
