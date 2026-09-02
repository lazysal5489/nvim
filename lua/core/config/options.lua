vim.opt.relativenumber = true
vim.opt.numberwidth = 4
vim.opt.number = true

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "Comment", { italic = true })
    vim.api.nvim_set_hl(0, "TSComment", { italic = true })
  end,
})

-- Picker
vim.g.lazyvim_picker = "telescope"
vim.g.lazyvim_cmp = "blink.cmp"
