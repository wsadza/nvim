----------------------
-- LSP 
----------------------

-- https://lsp-zero.netlify.app/v3.x/guide/what-to-do-when-lsp-doesnt-start.html

local lsp = require("lsp-zero").preset("recommended")

----------------------
-- HELM-LS 
----------------------
require('lspconfig').helm_ls.setup {
settings = {
  ['helm-ls'] = {
    yamlls = {
      path = "yaml-language-server",
    }
  }
}
}

----------------------
-- MASON 
----------------------
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls" },
  handlers = {
    function(server_name)
      require("lspconfig")[server_name].setup({})
    end,

    lua_ls = function()
      require("lspconfig").lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })
    end,
  },
})

lsp.setup()

--------------------------
-- YAML
--------------------------
require('lspconfig').yamlls.setup {
  settings = {
    yaml = {
      schemas = {
        kubernetes = "*.yaml","*yml",
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
  }
}

require('lspconfig').yamlls.setup{}

lsp.setup()
