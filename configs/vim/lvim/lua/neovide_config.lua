-- neovide_config.lua
local M = {}

function M.setup()
    if vim.g.neovide then
        -- Neovide configuration
        -- Refer to https://github.com/neovide/neovide/wiki/Configuration

        -- Font
        vim.o.guifont = 'Google Sans Code:h18'

        -- Window style & transparency
        vim.g.neovide_opacity = 0.85
        vim.g.neovide_fullscreen = false
        vim.g.neovide_window_blurred = true
        vim.g.neovide_remember_window_size = true

        -- Cursor effect: railgun
        vim.g.neovide_cursor_vfx_mode = 'railgun'
        vim.g.neovide_cursor_vfx_opacity = 10.0
        vim.g.neovide_cursor_vfx_particle_density = 10
        vim.g.neovide_cursor_trail_length = 0.8
        vim.g.neovide_cursor_animation_length = 0.12

        -- Profiler
        vim.g.neovide_profiler = false

        -- Zoom shortcuts (alt+= / alt+- / alt+0)
        vim.api.nvim_set_keymap('n', '<D-=>', ':lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<D-->', ':lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<D-0>', ':lua vim.g.neovide_scale_factor = 1.0<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('i', '<D-=>', '<Esc>:lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>a', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('i', '<D-->', '<Esc>:lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>a', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('i', '<D-0>', '<Esc>:lua vim.g.neovide_scale_factor = 1.0<CR>a', { noremap = true, silent = true })
    end
end

return M
