-- -- plugins.lua
local P = {}

P.set = {
    -- theme: https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#tree-sitter-supported-colorscheme
    { "nyoom-engineering/oxocarbon.nvim" },
    -- (removed: aurora, starry, kanagawa, gruvbox-material — kept only oxocarbon)
    -- file explorer
    { "theniceboy/joshuto.nvim" },
    -- :Copilot setup
    -- { "github/copilot.vim" },
    -- {
    --   "zbirenbaum/copilot.lua",
    --   cmd = "Copilot",
    --   event = "InsertEnter",
    --   config = function()
    --     require("copilot").setup({
    --       suggestion = {
    --         enabled = true,
    --         auto_trigger = true,
    --         hide_during_completion = true,
    --         debounce = 75,
    --         keymap = {
    --           accept = "<C-=>",
    --           accept_word = false,
    --           accept_line = false,
    --           next = "<C-;>",
    --           prev = "<C-'>",
    --           dismiss = "<C-->",
    --         },
    --       }
    --     })
    --   end,
    -- },
    -- {
    --     "zbirenbaum/copilot-cmp",
    --     config = function ()
    --       require("copilot_cmp").setup()
    --     end
    -- },
    -- { 'AndreM222/copilot-lualine' },
    -- https://github.com/liuchengxu/vim-clap/blob/master/INSTALL.md
    {
        "liuchengxu/vim-clap",
        build = ":Clap install-binary",
    },
    -- (removed: phaazon/hop.nvim — repo deleted)
    -- show git blame
    {
        "f-person/git-blame.nvim",
        event = "BufRead",
        config = function()
            vim.cmd "highlight default link gitblame SpecialComment"
            require("gitblame").setup { enabled = true }
        end,
    },
    { "fatih/vim-go" },
    -- (removed: olexsmir/gopher.nvim — redundant with vim-go)
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    },
    { "lvimuser/lsp-inlayhints.nvim" },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        dependencies = "nvim-treesitter/nvim-treesitter",
    },
    {
        "folke/trouble.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
    },
    {
        "simrat39/symbols-outline.nvim",
        config = function()
            require("symbols-outline").setup()
        end,
    },
    -- (removed: jose-elias-alvarez/typescript.nvim — archived, use built-in tsserver)
    {
        "mrcjkb/rustaceanvim",
        version = "^4",
        lazy = false,
    },
    {
        "saecki/crates.nvim",
        version = "v0.3.0",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("crates").setup {
                null_ls = {
                    enabled = true,
                    name = "crates.nvim",
                },
                popup = {
                    border = "rounded",
                },
            }
        end,
    },
    { "gpanders/editorconfig.nvim" },
    -- (removed: tact-lang plugins — TON-specific, not needed)
    -- :DiffviewOpen / :DiffviewClose
    { "sindrets/diffview.nvim" },
    {
				"iamcco/markdown-preview.nvim",
				cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
				ft = { "markdown" },
				build = function() vim.fn["mkdp#util#install"]() end,
		},
		{
				"karb94/neoscroll.nvim",
				event = "WinScrolled",
				config = function()
				require('neoscroll').setup({
						-- All these keys will be mapped to their corresponding default scrolling animation
						mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
						hide_cursor = true,          -- Hide cursor while scrolling
						stop_eof = true,             -- Stop at <EOF> when scrolling downwards
						use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
						respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
						cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
						easing_function = nil,        -- Default easing function
						pre_hook = nil,              -- Function to run before the scrolling animation starts
						post_hook = nil,              -- Function to run after the scrolling animation ends
						})
				end
		},
        {
				"folke/todo-comments.nvim",
				event = "BufRead",
				config = function()
					require("todo-comments").setup()
				end,
		},
		{
				"itchyny/vim-cursorword",
				event = {"BufEnter", "BufNewFile"},
				config = function()
					vim.api.nvim_command("augroup user_plugin_cursorword")
					vim.api.nvim_command("autocmd!")
					vim.api.nvim_command("autocmd FileType NvimTree,lspsagafinder,dashboard,vista let b:cursorword = 0")
					vim.api.nvim_command("autocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endif")
					vim.api.nvim_command("autocmd InsertEnter * let b:cursorword = 0")
					vim.api.nvim_command("autocmd InsertLeave * let b:cursorword = 1")
					vim.api.nvim_command("augroup END")
					end
		},
        -- Wakatime plugin to track time
		{ 'wakatime/vim-wakatime', lazy = false },
        -- (removed: terryma/vim-multiple-cursors — deprecated; cryshado/neovim-ton-dev — TON-specific)
    {
        "NickvanDyke/opencode.nvim",
        dependencies = {
          { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
        },
        config = function()
          ---@type opencode.Opts
          vim.g.opencode_opts = {}

          vim.o.autoread = true

          -- Keymaps
          vim.keymap.set({ "n", "x" }, "<leader>aa", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Opencode Ask" })
          vim.keymap.set({ "n", "x" }, "<leader>ae", function() require("opencode").select() end, { desc = "Opencode Select/Edit" })
          vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end, { desc = "Toggle opencode" })
          vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end, { expr = true, desc = "Add range to opencode" })
          vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end, { expr = true, desc = "Add line to opencode" })
        end,
    },


    -- === New Plugins ===
    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        opts = {
            background_colour = "#000000",
        },
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("noice").setup({
                notify = {
                    -- Use nvim-notify as the backend
                    view = "notify",
                },
            })
        end,
    },
    {
        "vhyrro/neorg",
        dependencies = { "nvim-lua/plenary.nvim" },
        init = function()
            -- Add neorg's LuaRocks deps to the Lua path
            local lazy_dir = vim.fn.expand("~/.local/share/lunarvim/lazy")
            local deps = { "lua-utils.nvim", "pathlib.nvim", "nvim-nio" }
            for _, dep in ipairs(deps) do
                local base = lazy_dir .. "/" .. dep .. "/lua/"
                package.path = base .. "?.lua;" .. base .. "?/init.lua;" .. package.path
            end
            -- Add nvim-treesitter parser dir to cpath so neorg can find norg/norg_meta parsers
            local ts_parser_dir = vim.fn.expand("~/.local/share/lunarvim/site/pack/lazy/opt/nvim-treesitter")
            package.cpath = ts_parser_dir .. "/?.so;" .. package.cpath
        end,
        config = function()
            require("neorg").setup {
                load = {
                    ["core.defaults"] = {},
                    ["core.concealer"] = {},
                    ["core.dirman"] = {
                        config = {
                            workspaces = {
                                notes = "~/notes",
                            },
                            default_workspace = "notes",
                            open_last_workspace = "default",
                        },
                    },
                    ["core.integrations.treesitter"] = {
                        config = {
                            warn_missing_parsers = false,
                        },
                    },
                },
            }
        end,
    },
    {
        "folke/edgy.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "smiteshp/nvim-navic",
        dependencies = "neovim/nvim-lspconfig",
        config = function()
            require("nvim-navic").setup {
                separator = " > ",
                highlight = true,
                depth_limit = 5,
            }
        end,
    },
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("oil").setup {
                default_file_explorer = false,
                view_options = { show_hidden = true },
            }
            vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
        end,
    },
    {
        "sphamba/smear-cursor.nvim",
        opts = {
            smear_between_neighbor_lines = true,
            stiffness = 0.6,
        },
    },
    {
        "chrisgrieser/nvim-spider",
        keys = {
            { "w", function() require("spider").motion("w") end, desc = "Spider-w" },
            { "e", function() require("spider").motion("e") end, desc = "Spider-e" },
            { "b", function() require("spider").motion("b") end, desc = "Spider-b" },
        },
    },
}

return P

