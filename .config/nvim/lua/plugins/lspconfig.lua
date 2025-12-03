return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", opts = {} },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "saghen/blink.cmp",
  },

  config = function()
    ------------------------------------------------------------------------
    -- LSP ATTACH
    ------------------------------------------------------------------------
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          vim.keymap.set(mode or "n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        -- Highlight references
        if client and client:supports_method("textDocument/documentHighlight") then
          local hl = vim.api.nvim_create_augroup("lsp-highlight", { clear = true })

          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = hl,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = hl,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
            callback = function(e)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = e.buf })
            end,
          })
        end

        -- Inlay hints toggle
        if client and client:supports_method("textDocument/inlayHint") then
          map("<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
          end, "Toggle Inlay Hints")
        end

        map("<leader>rn", vim.lsp.buf.rename, "Rename")
        map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("]d", vim.diagnostic.goto_next, "Next Diagnostic")
        map("[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
      end,
    })

    ------------------------------------------------------------------------
    -- DIAGNOSTICS
    ------------------------------------------------------------------------
    vim.diagnostic.config({
      severity_sort = true,
      float = { border = "rounded", source = "if_many" },
      underline = { severity = vim.diagnostic.severity.ERROR },
      signs = vim.g.have_nerd_font and {
        text = {
          [vim.diagnostic.severity.ERROR] = "󰅚 ",
          [vim.diagnostic.severity.WARN]  = "󰀪 ",
          [vim.diagnostic.severity.INFO]  = "󰋽 ",
          [vim.diagnostic.severity.HINT]  = "󰌶 ",
        },
      } or {},
      virtual_text = {
        source = "if_many",
        spacing = 2,
        format = function(d) return d.message end,
      },
      signs = true,
      underline = true,
      update_in_insert = false,
    })

    ------------------------------------------------------------------------
    -- CAPABILITIES
    ------------------------------------------------------------------------
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    ------------------------------------------------------------------------
    -- SERVER SETTINGS
    ------------------------------------------------------------------------
    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            completion = { callSnippet = "Replace" },
          },
        },
      },
      nixd = {},
    }

    ------------------------------------------------------------------------
    -- MASON INSTALLATION
    ------------------------------------------------------------------------
    local mason_servers = { "lua_ls" }

    require("mason-tool-installer").setup({
      ensure_installed = mason_servers,
    })

    ------------------------------------------------------------------------
    -- MASON-LSPCONFIG SETUP
    ------------------------------------------------------------------------
    require("mason-lspconfig").setup({
      handlers = {
        function(server_name)
          local opts = vim.tbl_deep_extend("force", {
            capabilities = capabilities,
          }, servers[server_name] or {})

          vim.lsp.config(server_name, opts)
          vim.lsp.enable({ server_name })
        end,
      },
    })
    vim.lsp.config("nixd", {
      capabilities = capabilities,
    })
    vim.lsp.enable({ "nixd" })
  end,
}
