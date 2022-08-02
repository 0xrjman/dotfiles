local keybindings = require("keybindings")

local opts = {
  settings = {
    cmd = { "solang", "--language-server", "--target", "ewasm" },
    filetypes = { 'solidity' },
  },
  on_attach = function(_, bufnr)
    -- 禁用格式化功能，交给专门插件插件处理
    -- client.resolved_capabilities.document_formatting = false
    -- client.resolved_capabilities.document_range_formatting = false
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    -- 绑定快捷键
    keybindings.mapLSP(buf_set_keymap)
    -- defaults
    keybindings.mapTsLSP(buf_set_keymap)
  end,
}
return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
