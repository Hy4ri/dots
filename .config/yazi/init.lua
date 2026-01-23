require("git"):setup()

require("full-border"):setup({
	type = ui.Border.PLAIN,
})

require("mime-preview"):setup()

require("session"):setup({
	sync_yanked = true,
})

require("mime-ext.local"):setup({
	with_exts = require("mime-preview"):get_mime_data(),
	fallback_file1 = true,
})

require("zoxide"):setup({
	update_db = true,
})

require("yaziline"):setup({
	color = "#990000",
	secondary_color = "#222222",
	default_files_color = "darkgray",
	selected_files_color = "white",
	yanked_files_color = "green",
	cut_files_color = "red",

	separator_style = "liney",

	select_symbol = "",
	yank_symbol = "󰆐",

	filename_max_length = 24,
	filename_truncate_length = 6,
	filename_truncate_separator = "...",
})
