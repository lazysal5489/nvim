local spec_file = vim.fn.expand("~/.config/quickshell/theme/current/neovim.lua")

local function apply_theme()
  if vim.fn.filereadable(spec_file) ~= 1 then
    return
  end
  local ok, spec = pcall(dofile, spec_file)
  if not ok or type(spec) ~= "table" or not spec[1] then
    return
  end

  local plugin = spec[1]

  -- ensure the colorscheme plugin is loaded via lazy.nvim (it's pre-installed)
  local lazy_ok, lazy = pcall(require, "lazy")
  if lazy_ok then
    local target = plugin.name or (type(plugin[1]) == "string" and plugin[1]:match("([^/]+)$") or nil)
    if target then
      pcall(function()
        lazy.load({ plugins = { target } })
      end)
    end
  end

  -- run the theme's own config (setup opts + colorscheme)
  vim.schedule(function()
    if plugin.config then
      pcall(plugin.config)
    end
  end)
end

local watcher = vim.loop.new_fs_event()
watcher:start(
  spec_file,
  {},
  vim.schedule_wrap(function(err)
    if err then
      return
    end
    apply_theme()
  end)
)