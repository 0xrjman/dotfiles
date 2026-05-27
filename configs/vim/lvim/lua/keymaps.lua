M = {}
lvim.leader = "space"

-- Visual --
lvim.keys.visual_mode["J"] = ":m '>+1<CR>gv=gv"
lvim.keys.visual_mode["K"] = ":m '<-2<CR>gv=gv"

-- Normal --
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<C-d>"] = "<C-d>zz"
lvim.keys.normal_mode["<C-u>"] = "<C-u>zz"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<leader><leader>"] = ":Telescope buffers<CR>"
lvim.keys.normal_mode["<leader>t"] = "<CMD>Telescope live_grep<CR>"
lvim.keys.normal_mode["<leader>o"] = "<CMD>SymbolsOutline<CR>"
lvim.keys.normal_mode["<leader>mdo"] = ":DiffviewOpen<CR>"
lvim.keys.normal_mode["<leader>mdc"] = ":DiffviewClose<CR>"
lvim.keys.normal_mode["<leader>mj"] = ":Joshuto<CR>"
lvim.keys.normal_mode["<leader>mc"] = ":Clap<CR>"

-- local opts = { noremap = true, silent = true }
-- local keymap = vim.keymap.set
-- keymap("n", "<C-Space>", "<cmd>WhichKey \\<space><cr>", opts)
-- keymap("n", "<m-h>", "<C-w>h", opts)
-- keymap("n", "<m-j>", "<C-w>j", opts)
-- keymap("n", "<m-k>", "<C-w>k", opts)
-- keymap("n", "<m-l>", "<C-w>l", opts)
-- keymap("n", "<m-tab>", "<c-6>", opts)

return M
