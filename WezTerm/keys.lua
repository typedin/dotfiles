local wezterm = require('wezterm')
local act = wezterm.action

return {
    {
        key = 'h',
        mods = 'CTRL|SHIFT',
        action = act.ActivatePaneDirection('Left'),
    },
    {
        key = 'l',
        mods = 'CTRL|SHIFT',
        action = act.ActivatePaneDirection('Right'),
    },
    {
        key = 'k',
        mods = 'CTRL|SHIFT',
        action = act.ActivatePaneDirection('Up'),
    },
    {
        key = 'j',
        mods = 'CTRL|SHIFT',
        action = act.ActivatePaneDirection('Down'),
    },
    {
        key = '5',
        mods = 'CTRL|SHIFT',
        action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
    },
    {
        key = "'",
        mods = 'CTRL|SHIFT',
        action = act.SplitVertical({ domain = 'CurrentPaneDomain' }),
    },
}
