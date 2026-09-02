return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      menu = {
        border = "single", -- Options: "single", "double", "rounded", "shadow", "solid"
        winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder",
      },
      documentation = {
        window = {
          border = "single",
          winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder",
        },
      },
    },
    keymap = {
      preset = "enter",
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
    },
  },
}
