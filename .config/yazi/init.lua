require("git"):setup()

require("full-border"):setup({
	type = ui.Border.PLAIN,
})

require("mime-preview"):setup()

require("session"):setup({
	sync_yanked = true,
})

require("mime-ext"):setup({
	with_exts = require("mime-preview"):get_mime_data(),
	fallback_file1 = true,
})

require("zoxide"):setup({
	update_db = true,
})

-- require("yatline"):setup({
-- 	--theme = my_theme,
-- 	section_separator = { open = "", close = "" },
-- 	part_separator = { open = "", close = "" },
-- 	inverse_separator = { open = "", close = "" },
--
-- 	style_a = {
-- 		fg = "#121212",
-- 		bg_mode = {
-- 			normal = "#990000",
-- 			select = "#e2e2e2",
-- 		},
-- 	},
-- 	style_b = { bg = "#222222", fg = "#c2c2c2" },
-- 	style_c = { bg = "#121212", fg = "#b2b2b2" },
--
-- 	permissions_t_fg = "green",
-- 	permissions_r_fg = "yellow",
-- 	permissions_w_fg = "red",
-- 	permissions_x_fg = "cyan",
-- 	permissions_s_fg = "white",
--
-- 	tab_width = 20,
-- 	tab_use_inverse = false,
--
-- 	selected = { icon = "󰻭", fg = "yellow" },
-- 	copied = { icon = "", fg = "green" },
-- 	cut = { icon = "", fg = "red" },
--
-- 	total = { icon = "󰮍", fg = "yellow" },
-- 	succ = { icon = "", fg = "green" },
-- 	fail = { icon = "", fg = "red" },
-- 	found = { icon = "󰮕", fg = "blue" },
-- 	processed = { icon = "󰐍", fg = "green" },
--
-- 	show_background = true,
--
-- 	display_header_line = false,
-- 	display_status_line = true,
--
-- 	component_positions = { "header", "tab", "status" },
--
-- 	status_line = {
-- 		left = {
-- 			section_a = {
-- 				{ type = "string", custom = false, name = "tab_mode" },
-- 			},
-- 			section_b = {
-- 				{ type = "string", custom = false, name = "hovered_path" },
-- 			},
-- 			section_c = {
-- 				{ type = "string", custom = false, name = "hovered_file_extension", params = { true } },
-- 				{ type = "string", custom = false, name = "hovered_size" },
-- 				{ type = "coloreds", custom = false, name = "count" },
-- 			},
-- 		},
-- 		right = {
-- 			section_a = {
-- 				{ type = "string", custom = false, name = "date", params = { "%I:%M" } },
-- 			},
-- 			section_b = {
-- 				{ type = "string", custom = false, name = "cursor_position" },
-- 			},
-- 			section_c = {
-- 				{ type = "coloreds", custom = false, name = "permissions" },
-- 			},
-- 		},
-- 	},
-- })
