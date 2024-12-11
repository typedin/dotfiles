local wezterm = require("wezterm")
local mux = wezterm.mux
local scandir = require("utils.functions").scandir

local function readjust_font_size(window, pane)
    local window_dims = window:get_dimensions()
    local pane_dims = pane:get_dimensions()
    local config_overrides = {}
    local initial_font_size = window:effective_config()["font_size "] or 10.0 -- set font size from config
    config_overrides.font_size = initial_font_size

    local iteration_count = 0
    local max_iterations = 5 -- How many time to try
    local tolerance = 3 -- How many pixels at the bottom are tolerated

    -- Calculate the initial difference between window and pane heights
    local current_diff = window_dims.pixel_height - pane_dims.pixel_height
    local min_diff = math.abs(current_diff)
    local best_font_size = initial_font_size

    -- Loop to adjust font size until the difference is within tolerance or max iterations reached
    while current_diff > tolerance and iteration_count < max_iterations do
        -- Increment the font size slightly
        config_overrides.font_size = config_overrides.font_size + 0.5
        window:set_config_overrides(config_overrides)

        -- Update dimensions after changing font size
        window_dims = window:get_dimensions()
        pane_dims = pane:get_dimensions()
        current_diff = window_dims.pixel_height - pane_dims.pixel_height

        -- Check if the current difference is the smallest seen so far
        local abs_diff = math.abs(current_diff)
        if abs_diff < min_diff then
            min_diff = abs_diff
            best_font_size = config_overrides.font_size
        end

        iteration_count = iteration_count + 1
    end

    -- If no acceptable difference was found, set the font size to the best one encountered
    if current_diff > tolerance then
        config_overrides.font_size = best_font_size
        window:set_config_overrides(config_overrides)
    end
end

local function resize_nvim_splits()
    local path = os.getenv("XDG_RUNTIME_DIR")
    if not path then
        return
    end
    local files = scandir(path)
    for _, value in ipairs(files) do
        if string.find(value, "nvim") then
            -- /!\ ligature /!\
            -- it's <Ctrl-w> = without space.
            local command = "nvim --server" .. "/run/user/1000/" .. value .. " --remote-send '<C-w>=' > /dev/null"
            os.execute(command)
        end
    end
end

-- Register the functions to be called when the window is resized
wezterm.on("window-resized", function(window, pane)
    readjust_font_size(window, pane)
    resize_nvim_splits()
end)

-- Register fullscreen action when wezterm starts
wezterm.on("gui-startup", function(a_window)
    local tab, pane, window = mux.spawn_window(a_window or {})
    local gui_window = window:gui_window()
    gui_window:perform_action(wezterm.action.ToggleFullScreen, pane)
end)
