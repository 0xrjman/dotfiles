-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
-- reference
-- https://github.com/ChristianChiarulli/lvim/tree/master/lua/user

-- Custom Plugins
lvim.plugins =
    {
      {"theniceboy/joshuto.nvim"},
      {"github/copilot.vim"},
      -- { "akinsho/toggleterm.nvim", version = "*", config = true }
      -- https://github.com/liuchengxu/vim-clap/blob/master/INSTALL.md
      --   { "liuchengxu/vim-clap" }
    }

-- Keybinds

-- ColorScheme
lvim.colorscheme = "retrobox"

-- Neovide configurations
if vim.g.neovide then
    -- Neovide configuration
    -- Refer to https://github.com/neovide/neovide/wiki/Configuration
    -- local success, _ = pcall(require, 'neovide')
    vim.g.neovide_cursor_vfx_mode = 'railgun'
    vim.g.neovide_fullscreen = false
    vim.o.guifont = 'Hack Nerd Font'
    vim.g.neovide_transparency = 0.7

    -- sonicboom, ripple, wireframe, railgun, pixiedust
    vim.g.neovide_cursor_vfx_mode = 'ripple'

    vim.g.neovide_cursor_trail_length = 0.8
    vim.g.neovide_cursor_animation_length = 0.12
    vim.g.neovide_cursor_vfx_particle_density = 10

    vim.g.neovide_profiler = false
    vim.g.neovide_remember_window_size = false
end

local dashboard = {}

local banner = {" [[                                           ]]", " [[                                           ]]",
                " [[                                           ]]",
                " [[    ██████╗ ██╗   ██╗ █████╗ ███╗   ██╗    ]]",
                " [[    ██╔══██╗╚██╗ ██╔╝██╔══██╗████╗  ██║    ]]",
                " [[    ██████╔╝ ╚████╔╝ ███████║██╔██╗ ██║    ]]",
                " [[    ██╔══██╗  ╚██╔╝  ██╔══██║██║╚██╗██║    ]]",
                " [[    ██║  ██║   ██║   ██║  ██║██║ ╚████║    ]]",
                " [[    ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝    ]]",
                " [[                                           ]]", " [[           [ version : X.X.X ]             ]]",
                " [[                                           ]]"}

dashboard.banner_small =
    {" [[    ██████╗ ██╗   ██╗ █████╗ ███╗   ██╗    ]]",
     " [[    ██╔══██╗╚██╗ ██╔╝██╔══██╗████╗  ██║    ]]",
     " [[    ██████╔╝ ╚████╔╝ ███████║██╔██╗ ██║    ]]",
     " [[    ██╔══██╗  ╚██╔╝  ██╔══██║██║╚██╗██║    ]]",
     " [[    ██║  ██║   ██║   ██║  ██║██║ ╚████║    ]]",
     " [[    ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝    ]]"}

dashboard.banner_alt_1 = {" [[                                           ]]",
                          " [[    ██████╗ ██╗   ██╗ █████╗ ███╗   ██╗    ]]",
                          " [[    ██╔══██╗╚██╗ ██╔╝██╔══██╗████╗  ██║    ]]",
                          " [[    ██████╔╝ ╚████╔╝ ███████║██╔██╗ ██║    ]]",
                          " [[    ██╔══██╗  ╚██╔╝  ██╔══██║██║╚██╗██║    ]]",
                          " [[    ██║  ██║   ██║   ██║  ██║██║ ╚████║    ]]",
                          " [[    ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝    ]]",
                          " [[           [ version : X.X.X ]             ]]"}

dashboard.banner_alt_2 = {" [[                                           ]]",
                          " [[                                           ]]",
                          " [[                                           ]]",
                          " [[                                           ]]",
                          " [[    ██████╗ ██╗   ██╗ █████╗ ███╗   ██╗    ]]",
                          " [[    ██╔══██╗╚██╗ ██╔╝██╔══██╗████╗  ██║    ]]",
                          " [[    ██████╔╝ ╚████╔╝ ███████║██╔██╗ ██║    ]]",
                          " [[    ██╔══██╗  ╚██╔╝  ██╔══██║██║╚██╗██║    ]]",
                          " [[    ██║  ██║   ██║   ██║  ██║██║ ╚████║    ]]",
                          " [[    ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝    ]]",
                          " [[           [ version : X.X.X ]             ]]",
                          " [[                                           ]]",
                          " [[                                           ]]",
                          " [[                                           ]]",
                          " [[                                           ]]"}

function dashboard.get_sections()
    local header = {
        type = "text",
        val = function()
            local alpha_wins = vim.tbl_filter(function(win)
                local buf = vim.api.nvim_win_get_buf(win)
                return vim.api.nvim_buf_get_option(buf, "filetype") == "alpha"
            end, vim.api.nvim_list_wins())

            if vim.api.nvim_win_get_height(alpha_wins[#alpha_wins]) < 36 then
                return dashboard.banner_small
            end
            return banner
        end,
        opts = {
            position = "center",
            hl = "Label"
        }
    }

    local text = require "lvim.interface.text"
    local lvim_version = require("lvim.utils.git").get_lvim_version()

    local footer = {
        type = "text",
        val = text.align_center({
            width = 0
        }, {"", "repo", "https://github.com/rjman-ljm/dotfiles"}, 0.5),
        opts = {
            position = "center",
            hl = "Number"
        }
    }

    local buttons = {
        opts = {
            hl_shortcut = "Include",
            spacing = 1
        },
        entries = {{"f", lvim.icons.ui.FindFile .. "  Find File", "<CMD>Telescope find_files<CR>"},
                   {"n", lvim.icons.ui.NewFile .. "  New File", "<CMD>ene!<CR>"},
                   {"p", lvim.icons.ui.Project .. "  Projects ", "<CMD>Telescope projects<CR>"},
                   {"r", lvim.icons.ui.History .. "  Recent files", ":Telescope oldfiles <CR>"},
                   {"t", lvim.icons.ui.FindText .. "  Find Text", "<CMD>Telescope live_grep<CR>"},
                   {"c", lvim.icons.ui.Gear .. "  Configuration",
                    "<CMD>edit " .. require("lvim.config"):get_user_config_path() .. " <CR>"},
                   {"q", lvim.icons.ui.Close .. "  Quit", "<CMD>quit<CR>"}}
    }
    return {
        header = header,
        buttons = buttons,
        footer = footer
    }
end

-- Core Plugins
lvim.builtin.alpha.dashboard.section = dashboard.get_sections()
