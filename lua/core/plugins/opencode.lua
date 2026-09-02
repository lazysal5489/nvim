return {
  "nickjvandyke/opencode.nvim",
  version = "*",

  dependencies = {
    {
      "folke/snacks.nvim",
      optional = true,
      opts = {
        input = {},
        picker = {
          actions = {
            opencode_send = function(...)
              return require("opencode").snacks_picker_send(...)
            end,
          },
          win = {
            input = {
              keys = {
                ["<A-a>"] = {
                  "opencode_send",
                  mode = { "n", "i" },
                },
              },
            },
          },
        },
      },
    },
  },

  config = function()
    -- Required for auto reload
    vim.o.autoread = true

    -- Plugin options
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Add options here later if needed
      server = {
        url = "http://localhost:4096",
        start = function() end, -- no-op, don't open embedded terminal
        stop = function() end,
      },
    }
    -- Ask about current file or selection
    vim.keymap.set({ "n", "x" }, "<leader>aa", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "OpenCode Ask" })

    -- Open prompt selector
    vim.keymap.set({ "n", "x" }, "<leader>as", function()
      require("opencode").select()
    end, { desc = "OpenCode Select" })

    -- Send code context
    vim.keymap.set({ "n", "x" }, "<leader>ac", function()
      return require("opencode").operator("@this ")
    end, {
      expr = true,
      desc = "OpenCode Context",
    })

    -- Send current line
    vim.keymap.set("n", "<leader>al", function()
      return require("opencode").operator("@this ") .. "_"
    end, {
      expr = true,
      desc = "OpenCode Line",
    })

    -- Scroll session up
    vim.keymap.set("n", "<leader>ak", function()
      require("opencode").command("session.half.page.up")
    end, { desc = "OpenCode Up" })

    -- Scroll session down
    vim.keymap.set("n", "<leader>aj", function()
      require("opencode").command("session.half.page.down")
    end, { desc = "OpenCode Down" })
  end,
}
