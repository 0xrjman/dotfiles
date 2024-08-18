-- -- plugins.lua
local P = {}

P.set = {
    -- theme: https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#tree-sitter-supported-colorscheme
    { "nyoom-engineering/oxocarbon.nvim" },
    { "ray-x/aurora" },
    { "ray-x/starry.nvim" },
    { "rebelot/kanagawa.nvim" },
    { "sainnhe/gruvbox-material" },
    -- file explorer
    { "theniceboy/joshuto.nvim" },
    -- :Copilot setup
    -- { "github/copilot.vim" },
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      config = function()
        require("copilot").setup({
          suggestion = {
            enabled = true,
            auto_trigger = true,
            hide_during_completion = true,
            debounce = 75,
            keymap = {
              accept = "<C-=>",
              accept_word = false,
              accept_line = false,
              next = "<C-;>",
              prev = "<C-'>",
              dismiss = "<C-->",
            },
          }
        })
      end,
    },
    {
        "zbirenbaum/copilot-cmp",
        config = function ()
          require("copilot_cmp").setup()
        end
    },
    { 'AndreM222/copilot-lualine' },
    -- https://github.com/liuchengxu/vim-clap/blob/master/INSTALL.md
    {
        "liuchengxu/vim-clap",
        build = ":Clap install-binary",
    },
    -- https://github.com/hadronized/hop.nvim
    {
        "phaazon/hop.nvim",
        event = "BufRead",
        config = function()
            require("hop").setup()
            vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
            vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
        end,
    },
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
    { "olexsmir/gopher.nvim" },
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
    { "jose-elias-alvarez/typescript.nvim" },
    { "simrat39/rust-tools.nvim" },
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
    { "tact-lang/tree-sitter-tact" },
    { "tact-lang/tact.vim"},
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
    { "terryma/vim-multiple-cursors" },
}

return P
