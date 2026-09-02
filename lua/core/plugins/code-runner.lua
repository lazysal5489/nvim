return {
  "CRAG666/code_runner.nvim",
  dependencies = { "akinsho/toggleterm.nvim" },
  cmd = { "RunCode", "RunFile", "RunProject" },
  keys = {
    { "<leader>rc", "<cmd>RunCode<cr>", desc = "Run Code" },
    { "<leader>rf", "<cmd>RunFile<cr>", desc = "Run File" },
    { "<leader>rp", "<cmd>RunProject<cr>", desc = "Run Project" },
  },
  opts = {
    filetype = {
      go = { "go", "run", "$fileName" },
      python = "python3",
      javascript = "node",
    },
  },
}
