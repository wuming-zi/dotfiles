require("full-border"):setup()
require("smart-enter"):setup({
	open_multi = true,
})
require("folder-rules"):setup()

local tokyo_night_theme = require("yatline-tokyo-night"):setup("night") -- or moon/storm/day
local catppuccin_theme = require("yatline-catppuccin"):setup("mocha") -- or "latte" | "frappe" | "macchiato"
local dracula_theme = require("yatline-dracula"):setup()
require("yatline"):setup({
	theme = tokyo_night_theme,
	-- theme = catppuccin_theme,
	-- theme = dracula_theme,
})

require("starship"):setup()
require("git"):setup({
	-- Order of status signs showing in the linemode
	order = 1500,
})
require("session"):setup({
	sync_yanked = true,
})
require("recycle-bin"):setup()

require("linemode-plus"):setup({
	-- Date formatting mode
	-- Available options:
	--   "default" - Yazi's native format with conditional year display:
	--               • For current year:     "MM/DD HH:mm"
	--               • For other years:      "MM/DD  YYYY"
	--
	--   "custom"  - smart user-defined format with today detection:
	--               • For today's files:     "HH:mm" (time only)
	--               • For older files:       Custom date format from 'custom' table
	--                 (configurable order, separator and year digits)
	date_mode = "custom",

	-- Custom format settings (only used when mode = "custom")
	custom = {
		-- Date components order
		-- MUST contain all three components: "year", "month", "day"
		-- Each component must appear exactly once (no duplicates)
		--
		-- All valid examples:
		--   { "year", "month", "day" }     -- year → month → day
		--   { "year", "day", "month" }     -- year → day → month
		--   { "month", "year", "day" }     -- month → year → day
		--   { "month", "day", "year" }     -- month → day → year
		--   { "day", "year", "month" }     -- day → year → month
		--   { "day", "month", "year" }     -- day → month → year
		order = { "year", "month", "day" },

		-- Separator between date components
		-- Allowed separators: "-", "/", "."  (only these characters are supported)
		--
		-- Examples:
		--   "-" -> 2026-02-20
		--   "/" -> 2026/02/20
		--   "." -> 2026.02.20
		separator = "/",

		-- Number of digits for the year:
		--   4 -> 2026 (full year)
		--   2 -> 26   (short year)
		year_digits = 2,
	},
})

require("mutilinemode"):setup({
	ext_width = 7, -- Filename extension width
	size_width = 6, -- Filesize width
	date_mode = "custom",
	custom = {
		-- Date part
		order = { "year", "month", "day" },
		separator = "/",
		year_digits = 4,
		-- Time part
		time_order = { "hour", "minute" }, -- {} to hide time
		time_separator = ":",
		sep_between_date_time = " ",
	},
})

-- You can configure your bookmarks using simplified syntax
-- local bookmarks = {
--   { tag = "Desktop", path = "~/Desktop", key = "d" },
--   { tag = "Documents", path = "~/Documents", key = "D" },
--   { tag = "Downloads", path = "~/Downloads", key = "o" },
-- }
require("projects"):setup({
	event = {
		save = {
			enable = true,
			name = "project-saved",
		},
		load = {
			enable = true,
			name = "project-loaded",
		},
		delete = {
			enable = true,
			name = "project-deleted",
		},
		delete_all = {
			enable = true,
			name = "project-deleted-all",
		},
		merge = {
			enable = true,
			name = "project-merged",
		},
	},
	save = {
		method = "yazi", -- yazi | lua
		yazi_load_event = "@projects-load", -- event name when loading projects in `yazi` method
		lua_save_path = "", -- path of saved file in `lua` method, comment out or assign explicitly
		-- default value:
		-- windows: "%APPDATA%/yazi/state/projects.json"
		-- unix: "~/.local/state/yazi/projects.json"
	},
	last = {
		update_after_save = true,
		update_after_load = true,
		update_before_quit = false,
		load_after_start = false,
	},
	merge = {
		event = "projects-merge",
		quit_after_merge = false,
	},
	notify = {
		enable = true,
		title = "Projects",
		timeout = 3,
		level = "info",
	},
})

-- You can also configure bookmarks with key arrays
local bookmarks = {
	{ tag = "Home", path = "~", key = { "z", "h" } },
	{ tag = "Desktop", path = "~/Desktop", key = { "z", "z" } },
	{ tag = "Documents", path = "~/Documents", key = { "z", "c" } },
	{ tag = "Downloads", path = "~/Downloads", key = { "z", "o" } },
	-- { tag = "Downloads", path = "Music", key = { "z", "m" } },
}
require("whoosh"):setup({
	-- Configuration bookmarks (cannot be deleted through plugin)
	bookmarks = bookmarks,

	-- Notification settings
	jump_notify = false,

	-- Key generation for auto-assigning bookmark keys
	keys = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",

	-- Configure the built-in menu action hotkeys
	-- false - hide menu item
	special_keys = {
		create_temp = "<Enter>", -- Create a temporary bookmark from the menu
		fuzzy_search = "<Space>", -- Launch fuzzy search (fzf)
		history = "<Tab>", -- Open directory history
		previous_dir = "<Backspace>", -- Jump back to the previous directory
	},

	-- File path for storing user bookmarks
	bookmarks_path = (
		ya.target_family() == "windows"
		and os.getenv("APPDATA") .. "\\yazi\\config\\plugins\\whoosh.yazi\\bookmarks"
	) or (os.getenv("HOME") .. "/.config/yazi/plugins/whoosh.yazi/bookmarks"),

	-- Replace home directory with "~"
	home_alias_enabled = true, -- Toggle home aliasing in displays

	-- Path truncation in navigation menu
	path_truncate_enabled = false, -- Enable/disable path truncation
	path_max_depth = 3, -- Maximum path depth before truncation

	-- Path truncation in fuzzy search (fzf)
	fzf_path_truncate_enabled = false, -- Enable/disable path truncation in fzf
	fzf_path_max_depth = 5, -- Maximum path depth before truncation in fzf

	-- Long folder name truncation
	path_truncate_long_names_enabled = false, -- Enable in navigation menu
	fzf_path_truncate_long_names_enabled = false, -- Enable in fzf
	path_max_folder_name_length = 20, -- Max length in navigation menu
	fzf_path_max_folder_name_length = 20, -- Max length in fzf

	-- History directory settings
	history_size = 10, -- Number of directories in history (default 10)
	history_fzf_path_truncate_enabled = false, -- Enable/disable path truncation by depth for history
	history_fzf_path_max_depth = 5, -- Maximum path depth before truncation for history (default 5)
	history_fzf_path_truncate_long_names_enabled = false, -- Enable/disable long folder name truncation for history
	history_fzf_path_max_folder_name_length = 30, -- Maximum length for folder names in history (default 30)
})

Status:children_add(function(self)
	local h = self._current.hovered
	if h and h.link_to then
		return " -> " .. tostring(h.link_to)
	else
		return ""
	end
end, 3300, Status.LEFT)
