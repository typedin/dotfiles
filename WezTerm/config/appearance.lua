local wezterm = require("wezterm")

local M = {
    color_scheme = "Tokyo Night Moon",
    font = wezterm.font("JetBrains Mono"), -- this font is bundled in @see https://wezfurlong.org/wezterm/config/fonts.html
    underline_thickness = 1,
    font_size = 10.0,
    font_shaper = "Harfbuzz",
    line_height = 1.9,
    window_background_opacity = 0.95,
    window_decorations = "RESIZE",
    audible_bell = "Disabled",
    default_cursor_style = "BlinkingBlock",
    cursor_blink_rate = 800,
    cursor_blink_ease_in = "EaseOut",
    cursor_blink_ease_out = "EaseIn",
    hide_mouse_cursor_when_typing = true,
    colors = {
        visual_bell = "#ff0000",
    },
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },
    visual_bell = {
        fade_in_function = "EaseOut",
        fade_in_duration_ms = 50,
        fade_out_function = "EaseOut",
        fade_out_duration_ms = 150,
        target = "CursorColor",
    },
}

return M
