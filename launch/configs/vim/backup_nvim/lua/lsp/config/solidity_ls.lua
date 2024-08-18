local keybindings = require("keybindings")
local bin_name = 'solidity-language-server'
if vim.fn.has 'win32' == 1 then
  bin_name = bin_name .. '.cmd'
end

local opts = {
  settings = {
    cmd = { bin_name, '--stdio' },
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
