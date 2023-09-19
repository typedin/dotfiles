-- Pull in the wezterm API
local wezterm = require('wezterm')
local keys = require('keys').keys

local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.front_end = 'OpenGL'
config.show_update_window = true
config.check_for_updates_interval_seconds = 86400 -- a day

config.color_scheme = 'Tokyo Night Moon'

config.font = wezterm.font('JetBrains Mono')

config.underline_thickness = 1
config.font_size = 10.0
config.line_height = 1.9
config.window_background_opacity = 0.95
config.window_decorations = 'RESIZE'
config.audible_bell = 'Disabled'
config.enable_tab_bar = false
config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_rate = 800
config.cursor_blink_ease_in = 'EaseOut'
config.cursor_blink_ease_out = 'EaseIn'

config.visual_bell = {
    fade_in_function = 'EaseOut',
    fade_in_duration_ms = 50,
    fade_out_function = 'EaseOut',
    fade_out_duration_ms = 150,
    target = 'CursorColor',
}
config.colors = {
    visual_bell = '#ff0000',
}

config.hide_mouse_cursor_when_typing = true

config.window_padding = {
    left = 2,
    right = 2,
    top = 0,
    bottom = 0,
}

config.keys = keys
return config
