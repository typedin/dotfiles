-- Pull in the wezterm API
local appearance = require("config")
local utils = require("utils.functions")
local wezterm = require("wezterm")
-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
local config = wezterm.config_builder()

utils.tbl_merge(config, appearance)

require("events")
-- must return a table
return config
