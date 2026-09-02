local function set_dir_icon_hl()
  vim.api.nvim_set_hl(0, "TelescopeDirIconWhite", { fg = "#ffffff", bold = true })
end
set_dir_icon_hl()
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = set_dir_icon_hl,
})
return {
  -- oil.nvim: owns `nvim .` and netrw, full-window buffer-style explorer
  {
    "stevearc/oil.nvim",
    opts = {
      default_file_explorer = true, -- oil owns netrw / `nvim .`
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["<C-h>"] = false,
        ["<C-j>"] = false,
        ["<C-k>"] = false,
        ["<C-l>"] = false,
      },
    },
    lazy = false,
    dependencies = { "nvim-mini/mini.icons" },
    keys = {
      { "<->", "<cmd>Oil<cr>", desc = "Open parent directory (Oil)" },
    },
  },

  -- telescope + telescope-file-browser: dropdown-style explorer on <leader>e
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-file-browser.nvim",
    },
    keys = {
      {
        "<leader>e",
        function()
          local telescope = require("telescope")
          local function telescope_buffer_dir()
            return vim.fn.expand("%:p:h")
          end
          telescope.extensions.file_browser.file_browser({
            path = "%:p:h",
            cwd = telescope_buffer_dir(),
            respect_gitignore = false,
            hidden = true,
            grouped = true,
            previewer = false,
            initial_mode = "normal",
            layout_config = { height = 40 },
          })
        end,
        desc = "Open File Browser with the path of the current buffer",
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local fb_actions = require("telescope").extensions.file_browser.actions

      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        wrap_results = true,
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        mappings = { n = {} },
      })

      opts.extensions = {
        file_browser = {
          theme = "dropdown",
          hijack_netrw = false,
          previewer = false,
          initial_mode = "normal",
          hidden = true,
          respect_gitignore = false,
          dir_icon = "",
          dir_icon_hl = "TelescopeDirIconWhite",
          grouped = true,
          quiet = true,
          layout_config = { height = 40 },
          mappings = {
            ["n"] = {
              ["N"] = fb_actions.create,
              ["h"] = fb_actions.goto_parent_dir,
              ["l"] = actions.select_default,
              ["/"] = function()
                vim.cmd("startinsert")
              end,
              ["<C-u>"] = function(prompt_bufnr)
                for _ = 1, 10 do
                  actions.move_selection_previous(prompt_bufnr)
                end
              end,
              ["<C-d>"] = function(prompt_bufnr)
                for _ = 1, 10 do
                  actions.move_selection_next(prompt_bufnr)
                end
              end,
              ["<PageUp>"] = actions.preview_scrolling_up,
              ["<PageDown>"] = actions.preview_scrolling_down,
            },
          },
        },
      }

      telescope.setup(opts)
      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")
    end,
  },
}
