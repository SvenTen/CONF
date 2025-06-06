-- ============================================================================
-- Language Server Protocol (LSP) Configuration
-- Provides code intelligence, diagnostics, and language-specific features
-- ============================================================================

---@diagnostic disable: undefined-global

local lspconfig = require("lspconfig")

-- ============================================================================
-- Diagnostic Configuration
-- ============================================================================

vim.diagnostic.config({
  severity_sort = true,
  float = { 
    border = "rounded",
    severity = { min = vim.diagnostic.severity.ERROR }, -- Only show errors in float
  },
  virtual_text = {
    prefix = '■ ',
    source = "if_many",
    spacing = 2,
    severity = { min = vim.diagnostic.severity.ERROR },
    virt_text_pos = 'eol', -- End of line (inline)
    virt_text_win_col = nil, -- Don't force specific column
  },
  underline = {
    severity = { min = vim.diagnostic.severity.ERROR }, -- Only underline errors
  },
  signs = {
    severity = { min = vim.diagnostic.severity.ERROR },
  },
  update_in_insert = false,
})

-- ============================================================================
-- LSP Capabilities
-- ============================================================================

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion = { dynamicRegistration = false }
capabilities.textDocument.publishDiagnostics = {
  relatedInformation = true,
  tagSupport = { valueSet = { 1, 2 } },
  versionSupport = false,
}

-- ============================================================================
-- On Attach Function (Keymaps and Features)
-- ============================================================================

local function on_attach(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- Navigation
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)

  -- Telescope integration for symbols (if available)
  local has_telescope, telescope = pcall(require, "telescope.builtin")
  if has_telescope then
    vim.keymap.set('n', '<leader>ds', telescope.lsp_document_symbols, opts)
    vim.keymap.set('n', '<leader>ws', telescope.lsp_dynamic_workspace_symbols, opts)
  else
    vim.keymap.set('n', '<leader>ds', vim.lsp.buf.document_symbol, opts)
    vim.keymap.set('n', '<leader>ws', vim.lsp.buf.workspace_symbol, opts)
  end

  -- Diagnostics (errors only due to config above)
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

  -- Document highlighting helper function
  local function supports_document_highlight(current_client)
    if vim.fn.has("nvim-0.11") == 1 then
      return current_client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, bufnr)
    else
      return current_client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, { bufnr = bufnr })
    end
  end

  -- Setup document highlighting if supported
  if supports_document_highlight(client) then
    local highlight_group = vim.api.nvim_create_augroup("LSPDocumentHighlight", { clear = false })

    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = bufnr,
      group = highlight_group,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      buffer = bufnr,
      group = highlight_group,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

-- ============================================================================
-- Server Configurations
-- ============================================================================
-- Enhanced clangd configuration for C/C++
local function setup_clangd()
  lspconfig.clangd.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--fallback-style=llvm",
    },
    init_options = {
      usePlaceholders = true,
      completeUnimported = true,
      clangdFileStatus = true,
    },
    flags = {
      debounce_text_changes = 150,
    },
  })
end

-- ============================================================================
-- Server Setup
-- ============================================================================

-- Try mason-lspconfig first, fallback to manual setup
local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if mason_lspconfig_ok then
  mason_lspconfig.setup_handlers({
    function(server_name)
      local server_opts = {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      if server_name == "clangd" then
        -- Use enhanced clangd setup
        setup_clangd()
        return
      elseif server_name == "lua_ls" then
        server_opts.settings = {
          Lua = {
            completion = { enable = false },
            diagnostics = {
              globals = { "vim" },
            },
          },
        }
      end

      lspconfig[server_name].setup(server_opts)
    end,
  })
else
  -- Fallback: Manual server setup
  setup_clangd()

  -- Setup lua_ls for Neovim configuration
  lspconfig.lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        completion = { enable = false },
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  })
end

-- ============================================================================
-- Auto Commands
-- ============================================================================

-- Notify when LSP attaches
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      vim.notify("LSP started: " .. client.name, vim.log.levels.INFO)
    end
  end,
})

-- Ensure clangd starts for C/C++ files even if mason-lspconfig fails
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  callback = function()
    -- Check if clangd is already attached
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    for _, client in pairs(clients) do
      if client.name == "clangd" then
        return -- Already attached
      end
    end
    
    -- If no clangd client, try to start it
    vim.schedule(function()
      setup_clangd()
    end)
  end,
})
