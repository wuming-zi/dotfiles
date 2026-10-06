local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

local function action_unless_fullscreen(action, key)
	return wezterm.action_callback(function(win, pane)
		if pane:is_alt_screen_active() then
			-- 程序全屏中（如 nvim、micro、less），把按键透传给程序
			win:perform_action(act.SendKey({ key = key, mods = "NONE" }), pane)
		else
			-- 普通终端，执行滚动历史
			win:perform_action(action, pane)
		end
	end)
end

-- 终端中使用翻页键翻页
config.keys = {
	{ key = "PageUp", mods = "NONE", action = action_unless_fullscreen(act.ScrollByPage(-0.5), "PageUp") },
	{ key = "PageDown", mods = "NONE", action = action_unless_fullscreen(act.ScrollByPage(0.5), "PageDown") },
}

config.mouse_bindings = {
	{
		event = { Down = { streak = 1, button = "Right" } },
		mode = "NONE",
		action = act.PasteFrom("Clipboard"),
	},
}

config.keys = {
	{
		key = "b",
		mods = "CTRL",
		action = wezterm.action.QuickSelectArgs({
			label = "open url",
			patterns = {
				"https?://\\S+",
			},
			skip_action_on_paste = true,
			action = wezterm.action_callback(function(window, pane)
				local url = window:get_selection_text_for_pane(pane)
				wezterm.log_info("opening: " .. url)
				wezterm.open_with(url)
			end),
		}),
	},
}

return config
