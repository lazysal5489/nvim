return {
  "folke/snacks.nvim",
  init = function()
    vim.defer_fn(function()
      local notify_timer = nil
      local delay_ms = 500

      local function blocked_key_cb()
        if notify_timer then
          notify_timer:stop()
          notify_timer:close()
          notify_timer = nil
        end
        notify_timer = vim.uv.new_timer()
        notify_timer:start(
          delay_ms,
          0,
          vim.schedule_wrap(function()
            vim.notify(
              "😐 Arrow keys? Seriously? Just quit Neovim at this point.",
              vim.log.levels.WARN,
              { title = "CMON BRUH" }
            )
            notify_timer:close()
            notify_timer = nil
          end)
        )
      end

      for _, key in ipairs({ "<Left>", "<Right>", "<Up>", "<Down>" }) do
        vim.keymap.set({ "n", "v" }, key, blocked_key_cb, { noremap = true, silent = true })
      end
    end, 2000)
  end,
}
