-- Pull in the wezterm API
local wezterm = require('wezterm')
local mux = wezterm.mux
local keys = require('keys')

wezterm.on('gui-startup', function(cmd)
    local window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.show_update_window = true
config.check_for_updates_interval_seconds = 86400 -- a day

config.color_scheme = 'nord'
config.font = wezterm.font('JetBrains Mono')

config.font_size = 10.0
config.window_background_opacity = 0.95
config.window_decorations = 'RESIZE'
config.audible_bell = 'Disabled'
config.line_height = 1.9
config.enable_tab_bar = false

config.hide_mouse_cursor_when_typing = true
config.integrated_title_buttons = { 'Hide', 'Maximize', 'Close' }

config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

config.keys = keys.keys
return config
