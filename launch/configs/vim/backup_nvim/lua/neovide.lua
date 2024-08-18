-- Neovide configuration
-- Refer to https://github.com/neovide/neovide/wiki/Configuration
-- local success, _ = pcall(require, 'neovide')
vim.g.neovide_cursor_vfx_mode = 'railgun'
vim.g.neovide_fullscreen=false
vim.o.guifont='Hack Nerd Font'
vim.g.neovide_transparency=0.7

-- sonicboom, ripple, wireframe, railgun, pixiedust
vim.g.neovide_cursor_vfx_mode = 'ripple'

vim.g.neovide_cursor_trail_length= 0.8
vim.g.neovide_cursor_animation_length=0.12
vim.g.neovide_cursor_vfx_particle_density=10

vim.g.neovide_profiler=false

vim.g.neovide_remember_window_size=false
