vim.o.background = "dark"
vim.g.tokyonight_style = "storm" -- day / night
-- 半透明
-- vim.g.tokyonight_transparent = true
-- vim.g.tokyonight_transparent_sidebar = true
local colorscheme = "nightfox"
-- tokyonight
-- OceanicNext
-- gruvbox
-- zephyr
-- nord
-- onedark
-- nightfox

local palettes = {
  nightfox = {
    red = '#eb5771',
    pink = "#ff8597",
    bg1 = "#2e3440",
    -- sel is different types of selection colors.
    sel0 = "#3e4a5b", -- Popup bg, visual selection bg
    sel1 = "#4f6074", -- Popup sel bg, search bg

    -- comment is the definition of the comment color.
    comment = "#60728a",
  },
}

local specs = {
  all = {
    syntax = {
      keyword = "pink",
      conditional = "pink.bright",
      number = "orange.dim",
    },
    git = {
      changed = "#f4a261",
    },
  },
  nightfox = {
    syntax = {
      operator = "orange",
    },
  },
}

local groups = {
  all = {
    -- Whitespace = { link = "Comment" },
    IncSearch = { bg = "palette.cyan" },
  },
  nightfox = {
    PmenuSel = { bg = "#73daca", fg = "bg0" },
  },
}

local opts = {
  options = {
    -- Inverse highlight for different types
    inverse = {
      match_paren = true,
      visual = true,
      search = true,
    },
    styles = {
      comments = "italic",
      keywords = "italic",
      types = "italic,bold",
    }
  },
  palettes = palettes,
  specs = specs,
  groups = groups,
}

local status, theme = pcall(require, colorscheme)
if not status then
  vim.notify("没有找到 theme: nightfox")
  return
end

theme.setup(opts)

-- 背景透明
vim.cmd("autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE \" transparent bg")

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme: " .. colorscheme .. " 没有找到！")
  return
end
