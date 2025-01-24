local wezterm = require "wezterm"

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.initial_cols = 120
config.initial_rows = 36
config.window_padding = {
    left = 8,
    right = 12,
    top = 0,
    bottom = 0,
}
config.default_cwd = wezterm.home_dir

config.enable_scroll_bar = true
config.enable_kitty_keyboard = true

config.color_scheme = "MaterialDark"
config.colors = {
    scrollbar_thumb = "#404040",
}
config.font = wezterm.font("FiraMono Nerd Font")
config.font_size = 12
config.freetype_load_target = "HorizontalLcd"

config.leader = { key = '\\', mods = 'SUPER' }
config.keys = {
    -- Disables
    {
        key = 'K', mods = 'CTRL|SHIFT',
        action = wezterm.action.DisableDefaultAssignment,
    },

    {
        key = '"', mods = 'CTRL|SHIFT|ALT',
        action = wezterm.action.DisableDefaultAssignment,
    },

    {
        key = '%', mods = 'CTRL|SHIFT|ALT',
        action = wezterm.action.DisableDefaultAssignment,
    },

    -- Customizations: Pane Controls
    {
        key = 'k', mods = 'SUPER',
        action = wezterm.action.Multiple({
            wezterm.action.ClearScrollback('ScrollbackAndViewport'),
            wezterm.action.SendKey({ key = 'l', mods = 'CTRL' })
        }),
    },

    {
        key = 'd', mods = 'CMD',
        action = wezterm.action.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
    },

    {
        key = 'd', mods = 'CMD|SHIFT',
        action = wezterm.action.SplitVertical({ domain = 'CurrentPaneDomain' }),
    },

    {
        key = 'l', mods = 'LEADER',
        action = wezterm.action.ShowLauncher,
    },

    -- Customizations: Text Navigation
    {
        key = 'LeftArrow', mods = 'ALT',
        action = wezterm.action.SendKey{
            mods = 'ALT',
            key = 'b',
        },
    },

    {
        key = 'RightArrow', mods = 'ALT',
        action = wezterm.action.SendKey{
            mods = 'ALT',
            key = "f",
        },
    },

    {
        key = 'LeftArrow', mods = 'SUPER',
        action = wezterm.action.SendKey{
            mods = 'CTRL',
            key = 'a',
        },
    },

    {
        key = 'RightArrow', mods = 'SUPER',
        action = wezterm.action.SendKey{
            mods = 'CTRL',
            key = 'e',
        },
    },

    {
        key = 'Home', mods = '',
        action = wezterm.action.SendKey{
            mods = 'CTRL',
            key = 'a',
        },
    },

    {
        key = 'End', mods = '',
        action = wezterm.action.SendKey{
            mods = 'CTRL',
            key = 'e',
        },
    },
}


return config
