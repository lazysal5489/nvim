local current_spec = vim.fn.expand("~/.config/quickshell/theme/current/neovim.lua")
if vim.fn.filereadable(current_spec) == 1 then
  local ok, spec = pcall(dofile, current_spec)
  if ok and type(spec) == "table" then
    return spec
  end
end

return {
  {
    "oskarnurm/koda.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme koda-dark")
    end,
  },
}