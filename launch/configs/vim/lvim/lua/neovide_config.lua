-- neovide_config.lua
local M = {}

function M.setup()
    if vim.g.neovide then
        -- Neovide configuration
        -- Refer to https://github.com/neovide/neovide/wiki/Configuration
        local success, _ = pcall(require, 'neovide')
        if not success then
            vim.notify('Neovide is not installed', 'error')
            return
        end
        vim.g.neovide_cursor_vfx_mode = 'railgun'
        vim.o.guifont = 'Hack Nerd Font'

        -- custom the style of window
        vim.g.neovide_transparency = 0.7
        vim.g.neovide_fullscreen = false
        vim.g.neovide_window_blurred = true

        -- sonicboom, ripple, wireframe, railgun, pixiedust, torpedo
        vim.g.neovide_cursor_vfx_mode = 'pixiedust'
        -- Options for configuring the particle generation and behavior.
        vim.g.neovide_cursor_vfx_opacity = 10.0

        vim.g.neovide_cursor_trail_length = 0.8
        vim.g.neovide_cursor_animation_length = 0.12
        vim.g.neovide_cursor_vfx_particle_density = 10

        vim.g.neovide_profiler = false
        vim.g.neovide_remember_window_size = true
    end
end

return M
