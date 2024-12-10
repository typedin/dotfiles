local wezterm = require("wezterm")
local mux = wezterm.mux

wezterm.on("gui-startup", function(window)
	local tab, pane, window = mux.spawn_window(window or {})
	local gui_window = window:gui_window()
	gui_window:perform_action(wezterm.action.ToggleFullScreen, pane)
end)

local appearance = require("config.appearance")
local keys = require("config.keys")
local gpu = require("config.gpu")
-- local tab_bar = require("config.tab-bar")
local utils = require("utils.functions")

local M = {}

utils.tbl_merge(M, appearance, keys, gpu)

return M
