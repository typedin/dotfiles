---Various utility functions
---
---@module "utils.functions"
---@author sravioli
---@license GNU-GPLv3

---@diagnostic disable-next-line: assign-type-mismatch
local wezterm = require("wezterm")

---User defined utility functions
---@class Utils.Fn
---@field fs    Utils.Fn.FileSystem
---@field str   Utils.Fn.String
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

M.fs.target_triple = wezterm.target_triple

-- {{{2 META

---@class Utils.Fn.FileSystem.Platform
---@field os "linux" The operating system name
---@field is_linux boolean Whether the platform is Linux.

-- }}}

---Determines the platform based on the target triple.
---
---This function checks the target triple string to determine if the platform is Windows, Linux, or macOS.
---
---@return Utils.Fn.FileSystem.Platform platform
M.fs.platform = function()
	return { os = "linux", is_linux = true }
end

---Gets the user home directory.
---
---This function retrieves the home directory path from environment variables or fallback
---sources and replaces backslashes with forward slashes.
---
---@return string home The path to the user home directory.
M.fs.home = function()
	local home = (os.getenv("USERPROFILE") or os.getenv("HOME") or wezterm.home or ""):gsub("\\", "/")
	return home
end

---Path separator based on the platform.
---
---This variable holds the appropriate path separator character for the current platform.
M.fs.path_separator = "/"

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
			hostname = cwd_uri.host or wezterm.hostname()
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
			hostname = wezterm.hostname()
		end
		hostname = hostname:gsub("^%l", string.upper)
	end

	cwd = cwd:gsub(M.fs.home() .. "(.-)$", "~%1")

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

	colorschemes = wezterm.color.get_builtin_schemes()
	for name, colors in pairs(require("colors")) do
		colorschemes[name] = colors
	end

	return colorschemes
end

---Returns the colorscheme name absed on the system appearance
---@return '"kanagawa-wave"'|'"kanagawa-lotus"' colorscheme name of the colorscheme
M.color.get_scheme = function()
	if (wezterm.gui and wezterm.gui.get_appearance() or ""):find("Dark") then
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

		config.tab_bar_style[state] = wezterm.format(ButtonLayout)
	end
end

-- }}}

-- Lua implementation of PHP scandir function
---@param directory string The directory in which we are operating. It must be absolute
---@return table files table of all files found
M.scandir = function(directory)
	if not directory then
		return {}
	end

	local i, files, popen = 0, {}, io.popen
	local pfile = popen('ls -a "' .. directory .. '"')
	if not pfile then
		return {}
	end

	for filename in pfile:lines() do
		i = i + 1
		files[i] = filename
	end
	pfile:close()
	return files
end

return M

-- vim: fdm=marker fdl=0
