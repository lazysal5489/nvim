return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    local my_colors = {
      bg = "#101010",
      fg = "#b0b0b0",
      white = "#ffffff",
      blue = "#458ee6",
      green = "#86cd82",
      red = "#701516",
      danger = "#ff7676",
      yellow = "#d9ba73",
      pink = "#f2a4db",
      gray = "#272727",
      lightgray = "#474747",
    }
    opts.options.theme = {
      normal = {
        a = { bg = my_colors.fg, fg = my_colors.bg, gui = "bold" },
        b = { bg = my_colors.gray, fg = my_colors.white },
        c = { bg = my_colors.bg, fg = my_colors.fg },
        x = { bg = my_colors.bg, fg = my_colors.fg },
        y = { bg = my_colors.gray, fg = my_colors.fg },
        z = { bg = my_colors.fg, fg = my_colors.bg },
      },
      insert = {
        a = { bg = my_colors.white, fg = my_colors.bg, gui = "bold" },
        b = { bg = my_colors.gray, fg = my_colors.fg },
        c = { bg = my_colors.bg, fg = my_colors.fg },
      },
      visual = {
        a = { bg = my_colors.yellow, fg = my_colors.bg, gui = "bold" },
        b = { bg = my_colors.gray, fg = my_colors.fg },
        c = { bg = my_colors.bg, fg = my_colors.fg },
      },
      replace = {
        a = { bg = my_colors.danger, fg = my_colors.bg, gui = "bold" },
        b = { bg = my_colors.gray, fg = my_colors.fg },
        c = { bg = my_colors.bg, fg = my_colors.fg },
      },
      inactive = {
        a = { bg = my_colors.lightgray, fg = my_colors.fg },
        b = { bg = my_colors.lightgray, fg = my_colors.fg },
        c = { bg = my_colors.bg, fg = my_colors.fg },
      },
    }
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
