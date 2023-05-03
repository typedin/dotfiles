-- Pull in the wezterm API
local wezterm = require('wezterm')
local mux = wezterm.mux
local keys = require('keys').keys

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

config.front_end = 'OpenGL'
config.show_update_window = true
config.check_for_updates_interval_seconds = 86400 -- a day

config.color_scheme = 'nordfox'
config.font = wezterm.font('JetBrains Mono')

config.foreground_text_hsb = {
    hue = 1.0,
    saturation = 1.5,
    brightness = 1.5,
}

config.font_size = 10.0
config.line_height = 1.9
config.window_background_opacity = 0.95
config.window_decorations = 'RESIZE'
config.audible_bell = 'Disabled'
config.enable_tab_bar = false
config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_rate = 800
config.cursor_blink_ease_in = 'EaseInOut'
config.cursor_blink_ease_out = 'EaseInOut'
config.visual_bell = {
    fade_in_function = 'EaseIn',
    fade_in_duration_ms = 150,
    fade_out_function = 'EaseOut',
    fade_out_duration_ms = 150,
}
config.hide_mouse_cursor_when_typing = true

config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

config.keys = keys
return config
