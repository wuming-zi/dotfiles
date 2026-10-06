local wezterm = require("wezterm")
local scheme = { "flexoki", "Catppuccin Mocha", "Dracula", "Tokyo Night" }
local fonts = { "Maple Mono NF CN", "Source Code Pro", "JetBrains Mono NL" }

return {
	color_scheme = scheme[3],
	font = wezterm.font(fonts[1], { weight = "Regular", italic = false }), -- 字体
	window_background_opacity = 0.8,
	wayland_window_background_blur = true,
	animation_fps = 120,
	max_fps = 120,
	font_size = 10,
	hide_tab_bar_if_only_one_tab = false,
	-- scrollbar
	enable_scroll_bar = false, -- 是否显示滚动条
	-- tab bar
	enable_tab_bar = false, -- 是否显示标签
	use_fancy_tab_bar = true,
	tab_max_width = 25,
	show_tab_index_in_tab_bar = false, -- 是否显示tab标签数
	switch_to_last_active_tab_when_closing_tab = true,
	-- window
	-- initial_cols = 140, -- 默认打开宽高
	-- initial_rows = 40,
	-- line_height = 1.06, -- 默认上下间距
	window_padding = { -- 四周padding，为0消除边框间距
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",
	default_cursor_style = "SteadyBar", -- 改变光标形状
}
