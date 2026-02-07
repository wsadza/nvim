----------------------
-- LSP (lsp-zero)
----------------------
local lsp = require("lsp-zero").preset("recommended")
local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

----------------------
-- MASON
----------------------
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "yamlls", "helm_ls" },
  handlers = {
    function(server_name)
      -- Don't let the generic handler clobber our custom setups
      if server_name == "yamlls" or server_name == "helm_ls" then
        return
      end
      lspconfig[server_name].setup({})
    end,

    lua_ls = function()
      lspconfig.lua_ls.setup({
        settings = {
          Lua = { diagnostics = { globals = { "vim" } } },
        },
      })
    end,
  },
})

lspconfig.helm_ls.setup({
  root_dir = util.root_pattern("Chart.yaml", "helmfile.yaml", ".git"),
  filetypes = { "helm", "yaml" }, -- optional: allow attaching on yaml too
  settings = {
    ["helm-ls"] = {
      yamlls = { path = "yaml-language-server" },
    },
  },
})

--lspconfig.helm_ls.setup({
--  root_dir = util.root_pattern("Chart.yaml", "helmfile.yaml", ".git"),
--})

--require("lspconfig").yamlls.setup({
--  settings = {
--    yaml = {
--      format = { enable = true },
--      validate = true,
--    },
--  },
--  -- disable yamlls for gotmpl buffers
--  on_attach = function(client, bufnr)
--    local name = vim.api.nvim_buf_get_name(bufnr)
--    if name:match("%.gotmpl$") then
--      vim.lsp.buf_detach_client(bufnr, client.id)
--    end
--  end,
--})

----------------------
-- HELM-LS
----------------------
lspconfig.helm_ls.setup({
  settings = {
    ["helm-ls"] = {
      yamlls = { path = "yaml-language-server" },
    },
  },
})

----------------------
-- YAML (ONE setup only)
----------------------
lspconfig.yamlls.setup({
  root_dir = util.root_pattern(".git", "Chart.yaml", "kustomization.yaml", "kustomization.yml"),
  single_file_support = true,
  settings = {
    yaml = {
      schemas = {
        kubernetes = { "*.yaml", "*.yml" },
        ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
        ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
        ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
        ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
        ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
        ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
        ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
        ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
        ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
        ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
        ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
      },
    },
  },
})

----------------------
-- Finish
----------------------
lsp.setup()
