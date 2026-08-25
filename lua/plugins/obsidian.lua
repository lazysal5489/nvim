return {
  "epwalsh/obsidian.nvim",

  version = "*",

  lazy = true,
  ft = "markdown",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
  },

  cmd = {
    "ObsidianBacklinks",
    "ObsidianDailies",
    "ObsidianExtractNote",
    "ObsidianFollowLink",
    "ObsidianLink",
    "ObsidianLinkNew",
    "ObsidianLinks",
    "ObsidianNew",
    "ObsidianNewFromTemplate",
    "ObsidianOpen",
    "ObsidianPasteImg",
    "ObsidianQuickSwitch",
    "ObsidianRename",
    "ObsidianSearch",
    "ObsidianTags",
    "ObsidianTemplate",
    "ObsidianToday",
    "ObsidianToggleCheckbox",
    "ObsidianTomorrow",
    "ObsidianTOC",
    "ObsidianYesterday",
  },

  keys = {
    { "<leader>on", "<cmd>ObsidianNew<CR>", desc = "New Note" },
    { "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", desc = "Quick Switch" },
    { "<leader>os", "<cmd>ObsidianSearch<CR>", desc = "Search Notes" },
    { "<leader>od", "<cmd>ObsidianToday<CR>", desc = "Daily Note" },
    { "<leader>ot", "<cmd>ObsidianTemplate<CR>", desc = "Insert Template" },
    { "<leader>ob", "<cmd>ObsidianBacklinks<CR>", desc = "Backlinks" },
    { "<leader>otm", "<cmd>ObsidianTomorrow<CR>", desc = "Tomorrow's Note" },
    { "<leader>oy", "<cmd>ObsidianYesterday<CR>", desc = "Yesterday's Note" },
  },

  opts = {
    workspaces = {
      {
        name = "vault",
        path = "~/Documents",
      },
    },

    notes_subdir = "inbox",

    daily_notes = {
      folder = "daily",
      date_format = "%Y-%m-%d",
      alias_format = "%B %-d, %Y",
    },

    templates = {
      folder = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },

    attachments = {
      img_folder = "attachments",
    },

    completion = {
      min_chars = 2,
    },

    note_id_func = function(title)
      if title ~= nil then
        return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        return tostring(os.time())
      end
    end,

    note_path_func = function(spec)
      local path = spec.dir / tostring(spec.id)
      return path:with_suffix(".md")
    end,

    wiki_link_func = "prepend_note_id",

    picker = {
      name = "telescope.nvim",
    },

    ui = {
      enable = true,
      checkboxes = {
        [" "] = { char = "󰄱" },
        ["x"] = { char = "" },
      },
    },
  },

  config = function(_, opts)
    require("obsidian").setup(opts)
  end,
}
