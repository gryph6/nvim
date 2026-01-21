local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0
}

config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

config.font = wezterm.font "BlexMono Nerd Font"

return config

