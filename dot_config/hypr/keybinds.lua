-- 快捷键核心（定稿 v2）｜由 hyprland.lua 末尾 require("keybinds") 加载
-- 标记：[保留]=注释待启用 ｜ [TODO]=Hyprland 无原生或需装软件再测试

local mainMod = "SUPER"
local ipc = "noctalia msg " -- 注意末尾空格

-- 应用命令
local terminal = "$TERMINAL"
local fileManager = "$TERMINAL -e yazi"
local browser = "$BROWSER"
local task = "$TERMINAL -e htop"

-- ══════════════════════════════════════════════════════════════════════════
--  系统应用
-- ══════════════════════════════════════════════════════════════════════════
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal)) -- 终端
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager)) -- 文件管理器
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser)) -- 浏览器
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher")) -- 启动器
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center")) -- 控制中心
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(ipc .. "wallpaper-random")) -- 下一张壁纸

-- ══════════════════════════════════════════════════════════════════════════
--  窗口状态
-- ══════════════════════════════════════════════════════════════════════════
local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close()) -- 关窗口
-- closeWindowBind:set_enabled(false)

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" })) -- 最大化列
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" })) -- 真·全屏
hl.bind(mainMod .. " + C", hl.dsp.window.center()) -- 列居中

-- [TODO] Noctalia 剪贴板面板：
-- hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(ipc .. "panel-toggle clipboard"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("copyq toggle")) -- 剪贴板
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.window.float({ action = "toggle" })) -- 浮动切换

-- [TODO] Super+P            保留键
-- [TODO] Super+M            贴满屏幕边缘
-- [TODO] Super+Alt+M        列扩展填满可用宽度
-- [TODO] Super+Ctrl+C       所有可见列居中
-- [TODO] Super+Alt+V        浮动/平铺切焦点
-- [TODO] Super+O            工作区/窗口概览
-- [TODO] Super+Tab          标签式列显示
hl.bind(mainMod .. " + Tab", hl.dsp.group.next())
-- hl.bind(mainMod .. " + comma", hl.dsp.window.move({ into_or_create_group = "r" }))
-- hl.bind(mainMod .. " + period", hl.dsp.window.move({ into_or_create_group = "l" }))
hl.bind(mainMod .. " + SHIFT + comma", hl.dsp.window.move({ out_of_group = "r" }))
hl.bind(mainMod .. " + SHIFT + period", hl.dsp.window.move({ out_of_group = "l" }))

-- 吞：把「右邻」窗口吸进当前列
hl.bind(mainMod .. " + comma", function()
	hl.dispatch(hl.dsp.focus({ direction = "r" }))
	hl.dispatch(hl.dsp.window.move({ into_or_create_group = "l" }))
end)

hl.bind(mainMod .. " + period", function()
	-- 吞：把「左邻」窗口吸进当前列
	hl.dispatch(hl.dsp.focus({ direction = "l" }))
	hl.dispatch(hl.dsp.window.move({ into_or_create_group = "r" }))
end)

-- 吐：把组内当前窗口放到右边，焦点回到组
hl.bind(mainMod .. " + SHIFT + comma", function()
	hl.dispatch(hl.dsp.window.move({ out_of_group = "r" })) -- 吐到右边
	hl.dispatch(hl.dsp.focus({ direction = "l" })) -- 焦点回到组
end)

-- 吐：把组内当前窗口放到左边，焦点回到组
hl.bind(mainMod .. " + SHIFT + period", function()
	hl.dispatch(hl.dsp.window.move({ out_of_group = "l" })) -- 吐到左边
	hl.dispatch(hl.dsp.focus({ direction = "r" })) -- 焦点回到组
end)

-- ══════════════════════════════════════════════════════════════════════════
--  焦点 / 移动
-- ══════════════════════════════════════════════════════════════════════════
-- 四方向 + HJKL 等价
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- 移动列 / 窗口
hl.bind(mainMod .. "+ CTRL + left", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. "+ CTRL + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. "+ CTRL + up", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. "+ CTRL + down", hl.dsp.window.swap({ direction = "down" }))
hl.bind(mainMod .. "+ CTRL + H", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. "+ CTRL + L", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. "+ CTRL + K", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. "+ CTRL + J", hl.dsp.window.swap({ direction = "down" }))

-- [保留] Super+Ctrl+- / Super+Ctrl+=          （不绑）
hl.bind(mainMod .. " + Home", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + End", hl.dsp.focus({ workspace = "emptynm" }))
hl.bind(mainMod .. " + Page_Down", hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mainMod .. " + Page_Up", hl.dsp.focus({ workspace = "r-1" }))

hl.bind(mainMod .. " + CTRL + Home", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. " + CTRL + End", hl.dsp.window.move({ workspace = "emptynm" }))
hl.bind(mainMod .. " + CTRL + Page_Down", hl.dsp.window.move({ workspace = "m+1" }))
hl.bind(mainMod .. " + CTRL + Page_Up", hl.dsp.window.move({ workspace = "m-1" }))

-- [TODO] hyprland官方未实现工作区的移动
-- hl.bind(mainMod .. " + SHIFT + Page_Down", hl.dsp.window.move({ workspace = "m+1" }))
-- hl.bind(mainMod .. " + SHIFT + Page_Up", hl.dsp.window.move({ workspace = "m-1" }))

-- ══════════════════════════════════════════════════════════════════════════
--  工作区
-- ══════════════════════════════════════════════════════════════════════════
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i })) -- 焦点→工作区
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i })) -- 工作区→工作区
	hl.bind(mainMod .. " + CTRL + " .. key, hl.dsp.window.move({ workspace = i })) -- 列→工作区
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "r+1" })) -- 滚轮切工作区
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "r-1" }))

hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic")) -- 划出工作区
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" })) -- 移入划出区

-- [TODO] Super+Shift+Page_Up/Down   与相邻工作区交换内容
-- [保留] Super+Shift+- / Super+Shift+=

-- ══════════════════════════════════════════════════════════════════════════
--  显示器（单屏时为空操作）
-- ══════════════════════════════════════════════════════════════════════════

-- 跨屏焦点
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.focus({ monitor = "l" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.focus({ monitor = "r" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.focus({ monitor = "u" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.focus({ monitor = "d" }))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.focus({ monitor = "l" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.focus({ monitor = "r" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.focus({ monitor = "u" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.focus({ monitor = "d" }))

-- 列/窗口 → 该方向显示器（原来的 TODO，现在原生）
hl.bind(mainMod .. " + CTRL + SHIFT + left", hl.dsp.window.move({ monitor = "l" }))
hl.bind(mainMod .. " + CTRL + SHIFT + right", hl.dsp.window.move({ monitor = "r" }))
hl.bind(mainMod .. " + CTRL + SHIFT + up", hl.dsp.window.move({ monitor = "u" }))
hl.bind(mainMod .. " + CTRL + SHIFT + down", hl.dsp.window.move({ monitor = "d" }))

-- 工作区 → 该方向显示器（不用再填显示器名）
hl.bind(mainMod .. " + SHIFT + ALT + left", hl.dsp.workspace.move({ monitor = "l" }))
hl.bind(mainMod .. " + SHIFT + ALT + right", hl.dsp.workspace.move({ monitor = "r" }))
hl.bind(mainMod .. " + SHIFT + ALT + up", hl.dsp.workspace.move({ monitor = "u" }))
hl.bind(mainMod .. " + SHIFT + ALT + down", hl.dsp.workspace.move({ monitor = "d" }))

-- 按"顺序"切显示器（编号式，文档里的 relative）
hl.bind(mainMod .. " + SHIFT + ALT + Page_Down", hl.dsp.focus({ monitor = "+1" }))
hl.bind(mainMod .. " + SHIFT + ALT + Page_Up", hl.dsp.focus({ monitor = "-1" }))
-- [TODO] Super+Ctrl+Shift+方向/HJKL   列搬到该方向屏

-- ══════════════════════════════════════════════════════════════════════════
--  尺寸
-- ══════════════════════════════════════════════════════════════════════════
hl.bind(
	mainMod .. " + ALT + bracketleft",
	hl.dsp.window.resize({ x = -100, y = 0, relative = true }),
	{ repeating = true }
) -- 列宽 -10%
hl.bind(
	mainMod .. " + ALT + bracketright",
	hl.dsp.window.resize({ x = 100, y = 0, relative = true }),
	{ repeating = true }
) -- 列宽 +10%
hl.bind(mainMod .. " + ALT + equal", hl.dsp.window.resize({ x = 0, y = 100, relative = true }), { repeating = true }) -- 高度 +10%
hl.bind(mainMod .. " + ALT + minus", hl.dsp.window.resize({ x = 0, y = -100, relative = true }), { repeating = true }) -- 高度 -10%

-- [TODO] Super+] / Super+[    列宽预设循环
-- [TODO] Super+= / Super+-    高度预设循环
-- [TODO] Super+Alt+Shift+R    重置窗口高度
-- [保留] Super+Alt+Page_Up / Page_Down

-- ══════════════════════════════════════════════════════════════════════════
--  系统工具
-- ══════════════════════════════════════════════════════════════════════════
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd(ipc .. "session lock")) -- 锁屏
hl.bind(mainMod .. " + ALT + S", hl.dsp.exec_cmd(ipc .. "session suspend")) -- 挂起
hl.bind(mainMod .. " + ALT + H", hl.dsp.exec_cmd("systemctl hibernate")) -- 休眠
-- hl.bind(mainMod .. " + ALT + P", hl.dsp.exec_cmd(ipc .. "dpms-off")) -- 关显示器 --disable for VM
hl.bind(mainMod .. " + ALT + E", hl.dsp.exec_cmd(ipc .. "panel-toggle session")) -- 电源菜单
hl.bind(mainMod .. " + ALT + A", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center audio")) -- 音量混音器
hl.bind(mainMod .. " + ALT + W", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center wifi")) -- 网络面板
hl.bind(mainMod .. " + ALT + B", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center bluetooth")) -- 蓝牙面板
hl.bind(mainMod .. " + ALT + I", hl.dsp.exec_cmd(ipc .. "settings-toggle")) -- Noctalia 设置

-- [保留] qylock 版本（命令待定，二者留一）：
-- hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd("qylock"))
-- hl.bind(mainMod .. " + ALT + S", hl.dsp.exec_cmd("qylock-suspend"))

-- [保留] 装好后取消注释：
-- hl.bind(mainMod .. " + ALT + SHIFT + M", hl.dsp.exec_cmd(ipc .. "theme-mode-toggle"))  -- 明暗主题
-- hl.bind(mainMod .. " + ALT + R", hl.dsp.exec_cmd("obs --startrecording"))              -- 录屏
-- hl.bind(mainMod .. " + ALT + N", hl.dsp.exec_cmd("typora"))                            -- 笔记
-- hl.bind(mainMod .. " + ALT + C", hl.dsp.exec_cmd("hyprpicker -a"))                     -- 取色器
-- hl.bind(mainMod .. " + ALT + O", hl.dsp.exec_cmd("normcap"))                           -- OCR
-- hl.bind(mainMod .. " + ALT + D", hl.dsp.exec_cmd("udiskie-mount -a"))                  -- 磁盘
-- hl.bind(mainMod .. " + ALT + RETURN", hl.dsp.exec_cmd("..."))                          -- AI

-- [保留] 应用层：
-- hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("..."))         -- 代码编辑器
-- hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("..."))         -- 音乐
-- hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("..."))         -- 游戏
-- hl.bind(mainMod .. " + U", hl.dsp.exec_cmd("..."))         -- 日历
-- hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("..."))         -- 翻译
-- hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd("..."))         -- 预留
-- hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("..."))    -- 系统搜索

-- ══════════════════════════════════════════════════════════════════════════
--  会话 / 截图 / 鼠标
-- ══════════════════════════════════════════════════════════════════════════
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd(ipc .. "session logout")) -- 退出会话
hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd(ipc .. "session logout")) -- 退出会话
hl.bind("CTRL + SHIFT + escape", hl.dsp.exec_cmd(task)) -- 系统监视器
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("flameshot full -c")) -- 全屏截图

-- 区域截图
hl.bind("Print", function()
	local mon = hl.get_active_monitor()
	local n = mon and mon.id or 0
	hl.exec_cmd("flameshot screen --number " .. n .. " --edit")
end)

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true }) -- 拖动窗口
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- 缩放窗口

-- [保留] 备用退出方式：
-- hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"))

-- ══════════════════════════════════════════════════════════════════════════
--  媒体键
-- ══════════════════════════════════════════════════════════════════════════
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. "volume-up"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. "volume-down"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. "volume-mute"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. "brightness-up"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. "brightness-down"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)

-- ══════════════════════════════════════════════════════════════════════════
--  保留区（原 hyprland.lua 里的旧注释）
-- ══════════════════════════════════════════════════════════════════════════
-- hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
-- hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
-- hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("cliphist list | wofi --dmenu | cliphist decode | wl-copy"))
-- hl.bind(mainMod .. " + F2", hl.dsp.exec_cmd("pkill waybar || true && waybar"))
-- hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
-- hl.bind("ALT + Tab", hl.dsp.window.cycle_next({ next = true }))
-- hl.bind("ALT + Tab", hl.dsp.exec_cmd(ipc .. "window-switcher close"))
-- hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd("qs -p ~/.local/share/quickshell-overview ipc call overview toggle"))
-- hl.bind(mainMod .. " + comma", hl.dsp.exec_cmd(ipc .. "settings-toggle"))
-- hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
