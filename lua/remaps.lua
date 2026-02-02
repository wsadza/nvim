-------------------------
-- Chnage default leader key to space
-------------------------
vim.g.mapleader = " "

-------------------------
-- Invoke osc52 when using vim yank
-------------------------
vim.keymap.set("n", "<leader>pv", vim.cmd.NvimTreeOpen)

-------------------------
-- Invoke osc52 when using vim yank
-------------------------

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    print(vim.inspect(vim.v.event))
  end,
})

--vim.cmd([[ autocmd TextYankPost * lua require('osc52').copy_visual() ]])
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    if vim.v.event.operator ~= "y" then return end

    local ok, osc52 = pcall(require, "osc52")
    if not ok then return end

    -- regcontents works even when registers are bypassed
    local text = table.concat(vim.v.event.regcontents, "\n")
    osc52.copy(text)
  end,
})

-------------------------
-- Press space + c to switch colors
-------------------------
-- Define a list of colorschemes to cycle through
local colorschemes = {"kanagawa-lotus", "kanagawa-dragon" }

-- Initialize an index to track the current colorscheme
local current_index = 1

-- Define a function to cycle through the colorschemes
local function cycle_colorscheme()
  -- Apply the current colorscheme
  vim.cmd("colorscheme " .. colorschemes[current_index])
  -- Move to the next colorscheme in the list, wrap around if necessary
  current_index = current_index % #colorschemes + 1
end

-- Set up the key mapping to call the cycle_colorscheme function
vim.keymap.set("n", "<leader>c", cycle_colorscheme)

-- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
local luasnip = require("luasnip")
local cmp = require("cmp")

cmp.setup({

  -- ... Your other configuration ...

  mapping = {

    -- ... Your other mappings ...
   ['<CR>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
            if luasnip.expandable() then
                luasnip.expand()
            else
                cmp.confirm({
                    select = true,
                })
            end
        else
            fallback()
        end
    end),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

    -- ... Your other mappings ...
  },

  -- ... Your other configuration ...
})
