return {
  {
    "folke/snacks.nvim",
    opts = {
      explorer = {
        replace_netrw = false,
      },
      picker = {
        sources = {
          explorer = {
            enabled = false,
          },
        },
      },
    },
    keys = {
      { "<leader>e", false },
    },
  },
}
