-- Pull in the wezterm API
local wezterm = require('wezterm')
local mux = wezterm.mux

wezterm.on('gui-startup', function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.color_scheme = 'nord'
config.font = wezterm.font('JetBrains Mono')
config.show_update_window = true
config.check_for_updates_interval_seconds = 86400 -- a day

config.font_size = 10
config.window_background_opacity = 0.95
config.window_decorations = 'RESIZE'
config.audible_bell = 'Disabled'
config.line_height = 1.6

config.window_frame = {
    -- The font used in the tab bar.
    -- Roboto Bold is the default; this font is bundled
    -- with wezterm.
    -- Whatever font is selected here, it will have the
    -- main font setting appended to it to pick up any
    -- fallback fonts you may have used there.
    font = wezterm.font({ family = 'Roboto', weight = 'Bold' }),

    -- The size of the font in the tab bar.
    -- Default to 10. on Windows but 12.0 on other systems
    font_size = 9.0,

    -- The overall background color of the tab bar when
    -- the window is focused
    active_titlebar_bg = '#333333',

    -- The overall background color of the tab bar when
    -- the window is not focused
    inactive_titlebar_bg = '#333333',
}

config.colors = {
    tab_bar = {
        -- The color of the inactive tab bar edge/divider
        inactive_tab_edge = '#575757',
    },
}

return config
