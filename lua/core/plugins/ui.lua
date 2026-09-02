return {
  "snacks.nvim",
  opts = {
    dashboard = {
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        -- { section = "startup" },
      },
      preset = {
        header = [[
                                                                     
       ████ ██████           █████      ██                     
      ███████████             █████                             
      █████████ ███████████████████ ███   ███████████   
     █████████  ███    █████████████ █████ ██████████████   
    █████████ ██████████ █████████ █████ █████ ████ █████   
  ███████████ ███    ███ █████████ █████ █████ ████ █████  
 ██████  █████████████████████ ████ █████ █████ ████ ██████ 
]],
        keys = {
          { icon = " >", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " >", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " >", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " >", key = "t", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " >", key = "p", desc = "Find Projects", action = ":lua Snacks.dashboard.pick('projects')" },
          {
            icon = " >",
            key = "c",
            desc = "Open Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = " >", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
    styles = {
      notification = {
        border = "single",
      },
    },
  },
}
