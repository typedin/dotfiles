---@diagnostic disable: undefined-field

---Various utility functions
---
---@module "utils.functions"
---@author sravioli
---@license GNU-GPLv3

---@diagnostic disable-next-line: assign-type-mismatch
local wt = require("wezterm")

local floor, ceil = math.floor, math.ceil

---User defined utility functions
---@class Utils.Fn
---@field fs    Utils.Fn.FileSystem
---@field mt    Utils.Fn.Maths
---@field str   Utils.Fn.String
---@field key   Utils.Fn.Keymap
---@field color Utils.Fn.Color
local M = {}

---Merges two tables
---@param t1 table
---@param ... table[] one or more tables to merge
---@return table t1 modified t1 table
M.tbl_merge = function(t1, ...)
	local tables = { ... }

	for i = 1, #tables do
		local t2 = tables[i]
		for k, v in pairs(t2) do
			if type(v) == "table" then
				if type(t1[k] or false) == "table" then
					M.tbl_merge(t1[k] or {}, t2[k] or {})
				else
					t1[k] = v
				end
			else
				t1[k] = v
			end
		end
	end

	return t1
end

-- {{{1 Utils.Fn.FileSystem

---@class Utils.Fn.FileSystem
---@field private target_triple string
M.fs = {}

M.fs.target_triple = wt.target_triple

-- {{{2 META

---@class Utils.Fn.FileSystem.Platform
---@field os "windows"|"linux"|"mac"|"unknown" The operating system name
---@field is_win boolean Whether the platform is Windows.
---@field is_linux boolean Whether the platform is Linux.
---@field is_mac boolean Whether the platform is Mac.

-- }}}

---Determines the platform based on the target triple.
---
---This function checks the target triple string to determine if the platform is Windows,
---Linux, or macOS.
---
---@return Utils.Fn.FileSystem.Platform platform
M.fs.platform = function()
	local is_win = M.fs.target_triple:find("windows") ~= nil
	local is_linux = M.fs.target_triple:find("linux") ~= nil
	local is_mac = M.fs.target_triple:find("apple") ~= nil
	local os = is_win and "windows" or is_linux and "linux" or is_mac and "mac" or "unknown"
	return { os = os, is_win = is_win, is_linux = is_linux, is_mac = is_mac }
end

---Gets the user home directory.
---
---This function retrieves the home directory path from environment variables or fallback
---sources and replaces backslashes with forward slashes.
---
---@return string home The path to the user home directory.
M.fs.home = function()
	local home = (os.getenv("USERPROFILE") or os.getenv("HOME") or wt.home or ""):gsub("\\", "/")
	return home
end

---Path separator based on the platform.
---
---This variable holds the appropriate path separator character for the current platform.
M.fs.path_separator = M.fs.platform().is_win and "\\" or "/"

---Equivalent to POSIX `basename(3)`.
---
---This function extracts the base name (the final component) from a given path.
---
---@param path string Any string representing a path.
---@return string str The base name of the path.
M.fs.basename = function(path)
	local trimmed_path = path:gsub("[/\\]*$", "")
	local index = trimmed_path:find("[^/\\]*$")
	return index and trimmed_path:sub(index) or trimmed_path
end

---Searches for the git project root directory of the given directory path.
---
---This function traverses up the directory tree to find the `.git` directory, indicating
---the root of a git project.
---
---@param directory string The directory path to start searching from.
---@return string|nil git_root If found, the `git_root`, else `nil`.
M.fs.find_git_dir = function(directory)
	directory = directory:gsub("~", M.fs.home())

	while directory do
		local handle = io.open(directory .. "/.git/HEAD", "r")
		if handle then
			handle:close()
			directory = directory:gsub(M.fs.home(), "~")
			return directory
		elseif directory == "/" or directory == "" then
			break
		else
			directory = directory:match("(.+)/[^/]*")
		end
	end

	return nil
end

---Returns the current working directory and the hostname.
---
---This function retrieves the current working directory and the hostname from the
---provided pane object. Optionally, it can search for the git root instead.
---
---@param pane table The wezterm pane object.
---@param search_git_root_instead? boolean Whether to search for the git root instead.
---@return string cwd The current working directory.
---@return string hostname The hostname.
---@see Utils.Fn.FileSystem.find_git_dir
M.fs.get_cwd_hostname = function(pane, search_git_root_instead)
	local cwd, hostname = "", ""
	local cwd_uri = pane:get_current_working_dir()

	if cwd_uri then
		if type(cwd_uri) == "userdata" then
			cwd = cwd_uri.file_path
			hostname = cwd_uri.host or wt.hostname()
		else
			cwd_uri = cwd_uri:sub(8)
			local slash = cwd_uri:find("/")
			if slash then
				hostname = cwd_uri:sub(1, slash - 1)
				cwd = cwd_uri:gsub("%%(%x%x)", function(hex)
					return string.char(tonumber(hex, 16))
				end)
			end
		end

		local dot = hostname:find("[.]")
		if dot then
			hostname = hostname:sub(1, dot - 1)
		end
		if hostname == "" then
			hostname = wt.hostname()
		end
		hostname = hostname:gsub("^%l", string.upper)
	end

	if M.fs.platform().is_win then
		cwd = cwd:gsub("/" .. M.fs.home() .. "(.-)$", "~%1")
	else
		cwd = cwd:gsub(M.fs.home() .. "(.-)$", "~%1")
	end

	if search_git_root_instead then
		local git_root = M.fs.find_git_dir(cwd)
		cwd = git_root or cwd
	end

	return cwd, hostname
end

---Shortens the given path.
---
---This function truncates each component of a given path to a specified length.
---
---@param path string The path to shorten.
---@param len number The maximum length for each component of the path.
---@return string short_path
M.fs.pathshortener = function(path, len)
	local splitted_path = M.str.split(path, M.fs.path_separator)
	local short_path = ""
	for i = 1, #splitted_path do
		local dir = splitted_path[i]
		local short_dir = dir:sub(1, len)
		if short_dir == "" then
			break
		end
		short_path = short_path .. (short_dir == "." and dir:sub(1, len + 1) or short_dir) .. M.fs.path_separator
	end
	return short_path
end

-- }}}

-- {{{1 Utils.Fn.Maths

---@class Utils.Fn.Maths
M.mt = {}

---Rounds the given number to the nearest integer
---@param number number
---@return integer result closest integer number
M.mt.round = function(number)
	return floor(number + 0.5)
end

---Rounds the given number to the nearest multiple given.
---@param number number Any number.
---@param multiple number Any number.
---@return number result floating point number rounded to the closest multiple.
M.mt.mround = function(number, multiple)
	local remainder = number % multiple
	return number - remainder + (remainder > multiple * 0.5 and multiple or 0)
end

---Converts a float into an integer.
---@param number number
---@param increment? number
---@return integer result
M.mt.toint = function(number, increment)
	if increment then
		return floor(number / increment) * increment
	end
	return number >= 0 and floor(number + 0.5) or ceil(number - 0.5)
end

-- }}}

-- {{{1 Utils.Fn.String

---@class Utils.Fn.String
M.str = {}

---Returns a padded string and ensures that it's not shorter than 2 chars.
---@param s string input string
---@param padding? integer left/right padding. defaults to 1
---@return string s the padded string
M.str.pad = function(s, padding)
	s = type(s) ~= "string" and tostring(s) or s
	padding = padding or 1

	local pad = (" "):rep(padding)
	return ("%s%s%s"):format(pad, s, pad)
end

---Splits a string into an iterator of substrings based on a separator pattern.
---
---This function returns an iterator that yields substrings from the input string `s`
---separated by the specified pattern `sep`. It supports optional parameters to treat
---the separator as plain text and to trim empty segments.
---
---@usage
---```lua
---for segment in M.str.gsplit("a,b,c", ",") do
---  print(segment)  -- Outputs: "a", "b", "c"
---end
---```
---
---@param s string The input string to split.
---@param sep string The separator pattern to split the string by.
---@param opts? table|nil Optional parameters: `plain` (boolean): If true, treats the separator as plain text. `trimempty` (boolean): If true, trims empty segments from the start and end.
---@return function f An iterator function that returns the next substring on each call.
---
M.str.gsplit = function(s, sep, opts)
	local plain, trimempty
	opts = opts or {}
	plain, trimempty = opts.plain, opts.trimempty

	local start = 1
	local done = false

	-- For `trimempty`: queue of collected segments, to be emitted at next pass.
	local segs = {}
	local empty_start = true -- Only empty segments seen so far.

	local function _pass(i, j, ...)
		if i then
			assert(j + 1 > start, "Infinite loop detected")
			local seg = s:sub(start, i - 1)
			start = j + 1
			return seg, ...
		else
			done = true
			return s:sub(start)
		end
	end

	return function()
		if trimempty and #segs > 0 then
			-- trimempty: Pop the collected segments.
			return table.remove(segs)
		elseif done or (s == "" and sep == "") then
			return nil
		elseif sep == "" then
			if start == #s then
				done = true
			end
			return _pass(start + 1, start)
		end

		local seg = _pass(s:find(sep, start, plain))

		-- Trim empty segments from start/end.
		if trimempty and seg ~= "" then
			empty_start = false
		elseif trimempty and seg == "" then
			while not done and seg == "" do
				segs[1] = ""
				seg = _pass(s:find(sep, start, plain))
			end
			if done and seg == "" then
				return nil
			elseif empty_start then
				empty_start = false
				segs = {}
				return seg
			end
			if seg ~= "" then
				segs[1] = seg
			end
			return table.remove(segs)
		end

		return seg
	end
end

---Splits a string into a table of substrings based on a separator pattern.
---
---This function splits the input string `s` into substrings separated by the specified
---pattern `sep` and returns these substrings in a table. It supports optional parameters
---to treat the separator as plain text and to trim empty segments.
---
---@usage
---```lua
---local result = M.str.split("a,b,c", ",")
---for _, segment in ipairs(result) do
---  print(segment)  -- Outputs: "a", "b", "c"
---end
---```
---
---@param s string The input string to split.
---@param sep string The separator pattern to split the string by.
---@param opts? table|nil Optional parameters: `plain` (boolean): If true, treats the separator as plain text. `trimempty` (boolean): If true, trims empty segments from the start and end.
---@return table t A table containing the substrings.
M.str.split = function(s, sep, opts)
	local t = {}
	for c in M.str.gsplit(s, sep, opts) do
		t[#t + 1] = c
	end
	return t
end

-- }}}

-- {{{1 Utils.Fn.Keymap

---@class Utils.Fn.Keymap
---@field private aliases   table
---@field private modifiers table
M.key = {
	aliases = {
		CR = "Enter",
		BS = "Backspace",
		ESC = "Escape",
		Bar = "|",
		k0 = "Numpad0",
		k1 = "Numpad1",
		k2 = "Numpad2",
		k3 = "Numpad3",
		k4 = "Numpad4",
		k5 = "Numpad5",
		k6 = "Numpad6",
		k7 = "Numpad7",
		k8 = "Numpad8",
		k9 = "Numpad9",
	},

	modifiers = { C = "CTRL", S = "SHIFT", W = "SUPER", M = "ALT" },
}

---Maps an action using (n)vim-like syntax.
---
---This function allows you to map a key or a combination of keys to a specific action,
---using a syntax similar to that of (n)vim. The mapped keys and actions are inserted
---into the provided table.
---
---@param lhs string The key or key combination to map.
---@param rhs string|table A valid `wezterm.action.<action>` to execute upon keypress.
---@param tbl table The table in which to insert the keymaps.
---
---@usage
---```lua
---local keymaps = {}
---M.key.map("<leader>a", wezterm.action.ActivateTab(1), keymaps)
---M.key.map("<C-a>", wezterm.action.ActivateTab(2), keymaps)
---M.key.map("b", wezterm.action.SendString("hello"), keymaps)
---```
M.key.map = function(lhs, rhs, tbl)
	---Inserts the keymap in the table
	---@param mods? string modifiers. defaults to `""`
	---@param key string key to press.
	local function __map(key, mods)
		tbl[#tbl + 1] = { key = key, mods = mods or "", action = rhs }
	end

	---skip checks for single key mapping, just map it.
	if #lhs == 1 then
		return __map(lhs)
	end

	local aliases, modifiers = M.key.aliases, M.key.modifiers

	local mods = {}
	---search for a leader key
	if lhs:find("^<leader>") then
		lhs = (lhs:gsub("^<leader>", ""))
		mods[#mods + 1] = "LEADER"
	end

	if lhs:find("%b<>") then
		lhs = lhs:gsub("(%b<>)", function(str)
			return str:sub(2, -2)
		end)

		local keys = M.str.split(lhs, "%-")
		if #keys == 1 then
			return __map(aliases[keys[1]] or keys[1])
		end

		local k = keys[#keys]
		if modifiers[k] then
			return wt.log_error("keymap cannot end with modifier!")
		else
			table.remove(keys, #keys)
		end
		k = aliases[k] or k

		for i = 1, #keys do
			mods[#mods + 1] = modifiers[keys[i]]
		end

		return __map(k, table.concat(mods, "|"))
	end

	return __map(lhs, table.concat(mods, "|"))
end

-- }}}

-- {{{1 Utils.Fn.Color

---@class Utils.Fn.Color
M.color = {}

local colorschemes = nil

---Merge color schemes from multiple sources
---@return table colorschemes Full colorschemes table
M.color.get_schemes = function()
	if colorschemes then
		return colorschemes
	end

	colorschemes = wt.color.get_builtin_schemes()
	for name, colors in pairs(require("colors")) do
		colorschemes[name] = colors
	end

	return colorschemes
end

---Returns the colorscheme name absed on the system appearance
---@return '"kanagawa-wave"'|'"kanagawa-lotus"' colorscheme name of the colorscheme
M.color.get_scheme = function()
	if (wt.gui and wt.gui.get_appearance() or ""):find("Dark") then
		return "kanagawa-wave"
	end
	return "kanagawa-lotus"
end

---Sets the tab button style in the configuration based on the specified theme.
---
---This function updates the `config` object to set the style for the tab buttons
---(`new_tab` and `new_tab_hover`) using the color scheme provided in the `theme` object.
---It constructs the button layout with appropriate colors, separators, and text attributes.
---
---@usage
---```lua
---local config = {}
---local theme = {
---  tab_bar = {
---    new_tab = { bg_color = "#000000", fg_color = "#FFFFFF", intensity = "Bold" },
---    new_tab_hover = { bg_color = "#111111", fg_color = "#EEEEEE", italic = true },
---    background = "#222222"
---  }
---}
---M.color.set_tab_button(config, theme)
---```
---
---@param config table The configuration object to be updated with tab button styles.
---@param theme table The theme object containing color schemes for different tab states.
M.color.set_tab_button = function(config, theme)
	config.tab_bar_style = {}
	local sep = require("utils.class.icon").Sep.tb

	for _, state in ipairs({ "new_tab", "new_tab_hover" }) do
		local style = theme.tab_bar[state]
		local sep_bg, sep_fg = style.bg_color, theme.tab_bar.background

		---@class Layout
		local ButtonLayout = require("utils.class.layout"):new()
		local attributes = {
			style.intensity
				or (style.italic and "Italic")
				or (style.strikethrough and "Strikethrough")
				or (style.underline ~= "None" and style.underline),
		}

		ButtonLayout:push(sep_bg, sep_fg, sep.right, attributes)
		ButtonLayout:push(sep_bg, style.fg_color, " + ", attributes)
		ButtonLayout:push(sep_bg, sep_fg, sep.left, attributes)

		config.tab_bar_style[state] = wt.format(ButtonLayout)
	end
end

-- }}}

return M

-- vim: fdm=marker fdl=0
