-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- reload "plugins"
local plugins = require("plugins")
local neovide_config = require('neovide_config')
-- local plugins_config = require('plugins_config')
local dashboard = require('dashboard')

reload "options"
reload "keymaps"

-- Setup
neovide_config.setup()
-- plugins_config.setup()
dashboard.setup()

-- UI
lvim.transparent_window = true
lvim.colorscheme = "oxocarbon"
vim.o.mouse = "a"

-- Plugins
lvim.plugins = plugins.set

lvim.builtin.telescope.defaults.file_ignore_patterns = {
    ".git/",
    "target/",
    "docs/",
    "vendor/*",
    "%.lock",
    "__pycache__/*",
    "%.sqlite3",
    "%.ipynb",
    "node_modules/*",
    -- "%.jpg",
    -- "%.jpeg",
    -- "%.png",
    "%.svg",
    "%.otf",
    "%.ttf",
    "%.webp",
    ".dart_tool/",
    ".github/",
    ".gradle/",
    ".idea/",
    ".settings/",
    ".vscode/",
    "__pycache__/",
    "build/",
    "env/",
    "gradle/",
    "node_modules/",
    "%.pdb",
    "%.dll",
    "%.class",
    "%.exe",
    "%.cache",
    "%.ico",
    "%.pdf",
    "%.dylib",
    "%.jar",
    "%.docx",
    "%.met",
    "smalljre_*/*",
    ".vale/",
    "%.burp",
    "%.mp4",
    "%.mkv",
    "%.rar",
    "%.zip",
    "%.7z",
    "%.tar",
    "%.bz2",
    "%.epub",
    "%.flac",
    "%.tar.gz",
}

local existingLspWhichKeys = lvim.builtin.which_key.mappings["l"]
table.insert(existingLspWhichKeys, {
    name = "Inlay Hints",
    h = { "<cmd>lua require('lsp-inlayhints').toggle()<cr>", "Toggle Hints" },
})
