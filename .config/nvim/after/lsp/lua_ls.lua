-- Dynamically find the Hyprland stubs path
local function get_hypr_stubs()
  local hyprland_bin = vim.fn.exepath("hyprland")
  if hyprland_bin ~= "" then
    -- Convert /nix/store/.../bin/hyprland to /nix/store/.../share/hypr/stubs
    return hyprland_bin:gsub("/bin/hyprland$", "/share/hypr/stubs")
  end
  -- Fallback: Try a quick glob if hyprland isn't in the current PATH
  return vim.fn.glob("/nix/store/*hyprland*/share/hypr/stubs", true, true)[1]
end

local hypr_stubs = get_hypr_stubs()

return {
  on_attach = function(client, buf_id)
    client.server_capabilities.completionProvider.triggerCharacters = { ".", ":", "#", "(" }
  end,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
      diagnostics = {
        globals = { "hl" },
      },
      workspace = {
        ignoreSubmodules = true,
        library = {
          vim.env.VIMRUNTIME,
          hypr_stubs,
        },
      },
    },
  },
}
