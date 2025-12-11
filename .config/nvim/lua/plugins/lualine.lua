return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		---------------------------------------------------------------------
		-- Custom lualine theme (unchanged)
		---------------------------------------------------------------------
		local theme = {
			normal = {
				a = { fg = "#121212", bg = "#990000", gui = "bold" },
				b = { fg = "#c2c2c2", bg = "#222222" },
				c = { fg = "#b2b2b2", bg = "#121212" },
			},
			insert = {
				a = { fg = "#e2e2e2", bg = "#990000", gui = "bold" },
				b = { fg = "#c2c2c2", bg = "#222222" },
				c = { fg = "#b2b2b2", bg = "#121212" },
			},
			visual = {
				a = { fg = "#990000", bg = "#121212", gui = "bold" },
				b = { fg = "#c2c2c2", bg = "#222222" },
				c = { fg = "#b2b2b2", bg = "#121212" },
			},
			replace = {
				a = { fg = "#121212", bg = "#990000", gui = "bold" },
				b = { fg = "#c2c2c2", bg = "#222222" },
				c = { fg = "#b2b2b2", bg = "#121212" },
			},
		}

		---------------------------------------------------------------------
		-- Function: Show current search count (unchanged, already optimized)
		---------------------------------------------------------------------
		local function search_count()
			local search_pat = vim.fn.getreg("/")
			if search_pat == "" or vim.v.hlsearch == 0 then
				return ""
			end
			local sc = vim.fn.searchcount({ maxcount = 0 })
			if sc.total == 0 then
				return ""
			end
			return string.format("%d/%d", sc.current, sc.total)
		end

		---------------------------------------------------------------------
		-- Event-driven LSP client display
		---------------------------------------------------------------------
		-- This variable will hold our LSP string.
		-- The lualine component will just read this, not run a function.
		local lsp_clients_string = ""

		-- This function updates the string.
		local function update_lsp_clients()
			local clients = vim.lsp.get_clients({ bufnr = 0 })
			if next(clients) == nil then
				lsp_clients_string = ""
				return
			end
			local client_names = {}
			for _, client in ipairs(clients) do
				if not vim.tbl_contains(client_names, client.name) then
					table.insert(client_names, client.name)
				end
			end
			lsp_clients_string = table.concat(client_names, ", ")
		end

		-- We run the update function only on specific events, not every refresh.
		vim.api.nvim_create_autocmd({ "LspAttach", "LspDetach", "BufEnter" }, {
			callback = function()
				-- Defer to ensure LSP state is settled before we query it
				vim.defer_fn(function()
					update_lsp_clients()
					-- Manually refresh lualine to show the change
					require("lualine").refresh({ place = { "statusline" } })
				end, 100)
			end,
		})

		-- Function to display the cached LSP string
		local function lsp_client_display()
			return lsp_clients_string
		end

		---------------------------------------------------------------------
		-- Function: Show macro recording status
		---------------------------------------------------------------------
		local function recording_macro()
			local reg = vim.fn.reg_recording()
			if reg == "" then
				return ""
			end
			return " @" .. reg
		end


		---------------------------------------------------------------------
		-- Component functions for custom location
		---------------------------------------------------------------------
		local function loc_line() return vim.fn.line(".") end
		local function loc_total() return ":" .. vim.fn.line("$") .. "|" end
		local function loc_col() return vim.fn.col(".") end
		local function loc_max_col()
			local max_col = vim.fn.col("$") - 1
			if max_col < 0 then max_col = 0 end
			return ":" .. max_col
		end

		---------------------------------------------------------------------
		-- Lualine setup
		---------------------------------------------------------------------
		require("lualine").setup({
			options = {
				theme = theme,
				icons_enabled = true,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},

			-------------------------------------------------------------------
			-- Active sections layout
			-------------------------------------------------------------------
			sections = {
				-- Left side
				lualine_a = { "mode" },
				lualine_b = {
					{
						"filename",
						file_status = true,
						path = 0, -- Shows filename only
						symbols = { modified = "●", readonly = "", unnamed = "[No Name]" },
					},
					{ search_count },
				},
				lualine_c = {
					{ "branch", icon = "" },
					{
						"diff",
						symbols = { added = "+", modified = "~", removed = "-" },
						diff_color = {
							added = { fg = "#A3BE8C" },
							modified = { fg = "#EBCB8B" },
							removed = { fg = "#BF616A" },
						},
					},
				},

				-- Right side
				lualine_x = {
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						symbols = { error = " ", warn = " ", info = " ", hint = " " },
						colored = true,
					},
					{
						lsp_client_display,
					},
					{
						recording_macro,
						color = { fg = "#BF616A", gui = "bold" },
					},
					{ "fileformat" },
				},
				lualine_y = {
					{ loc_line, color = { fg = "#990000" }, padding = { left = 1, right = 0 }, separator = "" },
					{ loc_total, padding = { left = 0, right = 0 }, separator = "" },
					{ loc_col, color = { fg = "#990000" }, padding = { left = 0, right = 0 }, separator = "" },
					{ loc_max_col, padding = { left = 0, right = 1 } },
				},
				lualine_z = {
					{
						"datetime",
						style = "%I:%M", -- Matches your format
					},
				},
			},

			-------------------------------------------------------------------
			-- Inactive window sections
			-------------------------------------------------------------------
			inactive_sections = {
				lualine_a = {},
				-- Use the built-in filename component here too
				lualine_b = {
					{
						"filename",
						file_status = true,
						path = 1, -- Show relative path for inactive
					},
				},
				lualine_c = {},
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},

			-------------------------------------------------------------------
			-- No tabline or extensions used
			-------------------------------------------------------------------
			tabline = {},
			extensions = {},
		})

		---------------------------------------------------------------------
		-- Auto-update the macro indicator (unchanged)
		---------------------------------------------------------------------
		vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
			callback = function()
				vim.defer_fn(function()
					require("lualine").refresh({ place = { "statusline" } })
				end, 50)
			end,
		})
	end,
}
