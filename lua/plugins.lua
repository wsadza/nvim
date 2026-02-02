vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

  use {'wbthomason/packer.nvim'}

  use {'nvim-lua/plenary.nvim'}

  use {'towolf/vim-helm'}

  use {'nvim-telescope/telescope.nvim'}

  use { "David-Kunz/gen.nvim" }

  use {
    "someone-stole-my-name/yaml-companion.nvim",
    requires = {
        {'neovim/nvim-lspconfig'},
    },
    config = function()
      require("telescope").load_extension("yaml_schema")
    end,
  }

  use{'rebelot/kanagawa.nvim'}

  --use{
  --  'nvim-treesitter/nvim-treesitter',
  --  {
  --    run = ':TSUpdate'
  --  }
  --}

  use{'nvim-treesitter/playground'}

  use{'ojroques/nvim-osc52'}

  use{'williamboman/mason.nvim'}

  use { "L3MON4D3/LuaSnip", run = "make install_jsregexp" }

  use {
   'VonHeikemen/lsp-zero.nvim',
   branch = 'v3.x',
   requires = {
     {
      'williamboman/mason.nvim',
	run = function()
		pcall(vim.cmd, 'MasonUpdate')
	end,
     },
     {
	'williamboman/mason-lspconfig.nvim',
	tag = "v2.*",
     },
     {'neovim/nvim-lspconfig'},
     {'hrsh7th/nvim-cmp'},
     {'hrsh7th/cmp-nvim-lsp'},
     {'ts_ls'}
   }
  }

  use {'nvim-tree/nvim-tree.lua'}

  use {'nvim-tree/nvim-web-devicons'}

  use {'vim-airline/vim-airline' }

  use {'vim-airline/vim-airline-themes'}

end)
