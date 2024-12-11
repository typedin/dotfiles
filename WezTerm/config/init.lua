local appearance = require("config.appearance")
local keys = require("config.keys")
local gpu = require("config.gpu")
local tab_bar = require("config.tab-bar") -- tab bar is false
local utils = require("utils.functions")

local M = {}

utils.tbl_merge(M, appearance, keys, gpu, tab_bar)

return M
