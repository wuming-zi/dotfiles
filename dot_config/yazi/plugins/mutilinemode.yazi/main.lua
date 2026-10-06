-- ~/.config/yazi/plugins/muti-linemode.yazi/main.lua
--
-- muti-linemode — a multi-info linemode plugin for Yazi
-- Shows: file type | size | modified time | birth time
--
-- Usage:
--   init.lua : require("muti-linemode"):setup { ... }
--   yazi.toml: [mgr] linemode = "muti"   -- or "size_mtime"

---------------------------------------------------------------------
-- Defaults
---------------------------------------------------------------------
local DEFAULT_EXT_WIDTH = 7
local DEFAULT_SIZE_WIDTH = 8
local DEFAULT_DATE_WIDTH = 12 -- date width when date_mode = "default"

---------------------------------------------------------------------
-- Default configuration
---------------------------------------------------------------------
local DEFAULTS = {
	-- Column widths
	ext_width = DEFAULT_EXT_WIDTH, -- file type column (left-aligned)
	size_width = DEFAULT_SIZE_WIDTH, -- size column (right-aligned)

	-- Date mode:
	--   "default" - Yazi native format
	--               current year: "MM/DD HH:mm"
	--               other years : "MM/DD  YYYY"
	--   "custom"  - use the `custom` table below
	date_mode = "custom",

	custom = {
		-- -- Date part --
		-- Order of year / month / day
		-- Must contain all three components exactly once
		order = { "year", "month", "day" },
		separator = "-", -- only "-", "/", "." are allowed
		year_digits = 4, -- 4 -> 2026 ; 2 -> 26

		-- -- Time part (new) --
		-- Order of hour / minute / second
		-- Use an empty table {} to hide the time part
		-- Available: "hour", "minute", "second"
		time_order = { "hour", "minute" },
		time_separator = ":", -- separator between time components
		sep_between_date_time = " ", -- separator between date and time
	},
}

---------------------------------------------------------------------
-- Component -> strftime mapping
---------------------------------------------------------------------
local DATE_COMP = { month = "%m", day = "%d" }
local TIME_COMP = { hour = "%H", minute = "%M", second = "%S" }

local VALID_DATE = { year = true, month = true, day = true }
local VALID_TIME = { hour = true, minute = true, second = true }

---------------------------------------------------------------------
-- Runtime state (filled by setup)
---------------------------------------------------------------------
local S = {
	custom_date = true,
	date_fmt = "%Y-%m-%d %H:%M",
	width = 16,
	ext_width = DEFAULT_EXT_WIDTH,
	size_width = DEFAULT_SIZE_WIDTH,
}

---------------------------------------------------------------------
-- Utilities
---------------------------------------------------------------------
local function merge(dst, src)
	for k, v in pairs(src or {}) do
		if type(v) == "table" and type(dst[k]) == "table" then
			merge(dst[k], v)
		else
			dst[k] = v
		end
	end
	return dst
end

local function validate_order(order, valid, require_all)
	if type(order) ~= "table" then
		return false, "must be a table"
	end
	local seen = {}
	for _, k in ipairs(order) do
		if not valid[k] then
			return false, "invalid component: " .. tostring(k)
		end
		if seen[k] then
			return false, "duplicate component: " .. tostring(k)
		end
		seen[k] = true
	end
	if require_all then
		for k in pairs(valid) do
			if not seen[k] then
				return false, "missing component: " .. k
			end
		end
	end
	return true
end

local function build_fmt(order, comp, sep)
	if #order == 0 then
		return ""
	end
	local parts = {}
	for _, k in ipairs(order) do
		parts[#parts + 1] = comp[k]
	end
	return table.concat(parts, sep)
end

---------------------------------------------------------------------
-- Load and validate configuration (synced, same as linemode-plus)
---------------------------------------------------------------------
local load_config = ya.sync(function(_, opts)
	local cfg = merge(merge({}, DEFAULTS), opts or {})
	local c = cfg.custom

	S.ext_width = cfg.ext_width or DEFAULT_EXT_WIDTH
	S.size_width = cfg.size_width or DEFAULT_SIZE_WIDTH

	-- Validate date order
	local ok, err = validate_order(c.order, VALID_DATE, true)
	if not ok then
		ya.err("[muti-linemode] date order: " .. err)
		return
	end

	-- Validate separator
	if c.separator ~= "-" and c.separator ~= "/" and c.separator ~= "." then
		ya.err("[muti-linemode] separator must be one of '-', '/', '.'")
		return
	end

	-- Validate year_digits
	if c.year_digits ~= 2 and c.year_digits ~= 4 then
		ya.err("[muti-linemode] year_digits must be 2 or 4")
		return
	end

	-- Validate time order (an empty table is allowed)
	local torder = c.time_order or {}
	local ok2, err2 = validate_order(torder, VALID_TIME, false)
	if not ok2 then
		ya.err("[muti-linemode] time order: " .. err2)
		return
	end

	-- Build the date part
	local dcomp = {
		year = (c.year_digits == 4) and "%Y" or "%y",
		month = "%m",
		day = "%d",
	}
	local fmt = build_fmt(c.order, dcomp, c.separator)

	-- Append the time part
	local tfmt = build_fmt(torder, TIME_COMP, c.time_separator or ":")
	if tfmt ~= "" then
		fmt = fmt .. (c.sep_between_date_time or " ") .. tfmt
	end

	S.date_fmt = fmt
	S.width = #os.date(fmt, 0)
	S.custom_date = (cfg.date_mode == "custom")
end)

---------------------------------------------------------------------
-- Formatting helpers
---------------------------------------------------------------------
local function fmt_time(ts)
	ts = math.floor(ts or 0)
	if ts <= 0 then
		return string.rep(" ", S.custom_date and S.width or DEFAULT_DATE_WIDTH)
	end
	if S.custom_date then
		return os.date(S.date_fmt, ts)
	end
	-- "default" mode
	if os.date("%Y", ts) == os.date("%Y") then
		return os.date("%m/%d %H:%M", ts)
	end
	return os.date("%m/%d  %Y", ts)
end

local function file_ext(file)
	local cha = file.cha
	if cha.is_dir then
		return "dir"
	end
	if cha.is_link then
		return "link"
	end
	local ext = file.name and file.name:match("^.+%.([%w]+)$")
	return ext and ext:lower() or "file"
end

local function fmt_size(file)
	local size = file:size()
	if not size then
		return "-"
	end
	local s = ya.readable_size and ya.readable_size(size)
	if not s then
		-- Fallback implementation
		local units = { "B", "K", "M", "G", "T", "P", "E" }
		local i, n = 1, size
		while n >= 1024 and i < #units do
			n = n / 1024
			i = i + 1
		end
		s = string.format("%.1f%s", n, units[i])
	end
	return (s:gsub(" ", ""))
end

---------------------------------------------------------------------
-- Linemode: full info
---------------------------------------------------------------------
function Linemode:mutilinemode()
	local file = self._file
	local cha = file.cha
	return string.format(
		"%-" .. S.ext_width .. "s %" .. S.size_width .. "s  %s  %s",
		file_ext(file),
		fmt_size(file),
		fmt_time(cha.mtime),
		fmt_time(cha.btime)
	)
end

---------------------------------------------------------------------
-- Linemode: size + modified time (alternative)
---------------------------------------------------------------------
function Linemode:size_mtime()
	local file = self._file
	return string.format("%" .. S.size_width .. "s  %s", fmt_size(file), fmt_time(file.cha.mtime))
end

---------------------------------------------------------------------
-- Plugin entry
---------------------------------------------------------------------
return {
	setup = function(_, opts)
		load_config(opts)
	end,
}
