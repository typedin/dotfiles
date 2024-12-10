local battery_charge = require("wezterm").battery_info()[1].state_of_charge

local M = {}

M.front_end = "WebGpu"
M.webgpu_force_fallback_adapter = false

---switch to low power mode when battery is low
if battery_charge < 0.35 then
    M.webgpu_power_preference = "LowPower"
else
    M.webgpu_power_preference = "HighPerformance"
end

return M
