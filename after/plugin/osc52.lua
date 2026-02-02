------------------------
-- MASON 
------------------------

--initial
pcall(function()
  require("osc52").setup()
end)

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    if vim.v.event.operator ~= "y" then return end
    local ok, osc52 = pcall(require, "osc52")
    if not ok then return end

    local lines = vim.v.event.regcontents
    if type(lines) ~= "table" or #lines == 0 then
      lines = vim.fn.getreg('"', 1, true)
    end

    local text = table.concat(lines, "\n")
    if text ~= "" then osc52.copy(text) end
  end,
})
