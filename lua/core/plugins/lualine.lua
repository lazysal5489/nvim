return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    table.insert(opts.sections.lualine_x, {
      "fileformat",
      symbols = { unix = "" },
    })
    opts.sections.lualine_z = {
      {
        function()
          return " " .. os.date("%R")
        end,
        color = { gui = "bold" },
        icon = { "󰣇", color = { gui = "bold" } },
      },
    }
  end,
}
