return {
  on_attach = function(client, buf_id)
    if client.server_capabilities.completionProvider then
      client.server_capabilities.completionProvider.triggerCharacters = { ".", ":" }
    end
  end,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
      workspace = {
        ignoreSubmodules = true,
        library = { vim.fn.expand("~/.config/hypr") },
      },
      diagnostics = {
        globals = { "hl", "vim" },
      },
    },
  },
}
