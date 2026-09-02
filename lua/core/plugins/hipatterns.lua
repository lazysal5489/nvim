return {
  "nvim-mini/mini.hipatterns",
  event = "BufReadPre",
  opts = function(_, opts)
    local hipatterns = require("mini.hipatterns")

    local rgb_to_hex = function(r, g, b)
      r, g, b = math.floor(r + 0.5), math.floor(g + 0.5), math.floor(b + 0.5)
      r, g, b = math.min(255, math.max(0, r)), math.min(255, math.max(0, g)), math.min(255, math.max(0, b))
      return string.format("#%02x%02x%02x", r, g, b)
    end

    local hsl_to_rgb = function(h, s, l)
      h, s, l = h / 360, s / 100, l / 100
      if s == 0 then
        local v = l * 255
        return v, v, v
      end
      local function hue2rgb(p, q, t)
        if t < 0 then
          t = t + 1
        end
        if t > 1 then
          t = t - 1
        end
        if t < 1 / 6 then
          return p + (q - p) * 6 * t
        end
        if t < 1 / 2 then
          return q
        end
        if t < 2 / 3 then
          return p + (q - p) * (2 / 3 - t) * 6
        end
        return p
      end
      local q = l < 0.5 and l * (1 + s) or l + s - l * s
      local p = 2 * l - q
      local r = hue2rgb(p, q, h + 1 / 3)
      local g = hue2rgb(p, q, h)
      local b = hue2rgb(p, q, h - 1 / 3)
      return r * 255, g * 255, b * 255
    end

    local rgb_color = function(_, match)
      local r, g, b = match:match("rgb%(%s*(%d+)%s*,%s*(%d+)%s*,%s*(%d+)%s*%)")
      if r and g and b then
        return hipatterns.compute_hex_color_group(rgb_to_hex(tonumber(r), tonumber(g), tonumber(b)), "bg")
      end
    end

    local rgba_color = function(_, match)
      local r, g, b, a = match:match("rgba%(%s*(%d+)%s*,%s*(%d+)%s*,%s*(%d+)%s*,%s*([%d%.]+)%s*%)")
      if r and g and b then
        local alpha = tonumber(a) or 1
        return hipatterns.compute_hex_color_group(
          rgb_to_hex(tonumber(r) * alpha, tonumber(g) * alpha, tonumber(b) * alpha),
          "bg"
        )
      end
    end

    local rgba_hex_color = function(_, match)
      local hex = match:match("rgba%((%x%x%x%x%x%x%x%x)%)")
      if hex then
        local r = tonumber(hex:sub(1, 2), 16)
        local g = tonumber(hex:sub(3, 4), 16)
        local b = tonumber(hex:sub(5, 6), 16)
        local a = tonumber(hex:sub(7, 8), 16) / 255
        return hipatterns.compute_hex_color_group(rgb_to_hex(r * a, g * a, b * a), "bg")
      end
    end

    local hsl_color = function(_, match)
      local h, s, l = match:match("hsl%(%s*(%d+)%s*,%s*(%d+)%%?%s*,%s*(%d+)%%?%s*%)")
      if h and s and l then
        local r, g, b = hsl_to_rgb(tonumber(h), tonumber(s), tonumber(l))
        return hipatterns.compute_hex_color_group(rgb_to_hex(r, g, b), "bg")
      end
    end

    local hsla_color = function(_, match)
      local h, s, l, a = match:match("hsla%(%s*(%d+)%s*,%s*(%d+)%%?%s*,%s*(%d+)%%?%s*,%s*([%d%.]+)%s*%)")
      if h and s and l then
        local alpha = tonumber(a) or 1
        local r, g, b = hsl_to_rgb(tonumber(h), tonumber(s), tonumber(l))
        return hipatterns.compute_hex_color_group(rgb_to_hex(r * alpha, g * alpha, b * alpha), "bg")
      end
    end

    opts.highlighters = vim.tbl_extend("force", opts.highlighters or {}, {
      hex_color = hipatterns.gen_highlighter.hex_color({ priority = 2000 }),
      rgb_color = {
        pattern = "rgb%(%s*%d+%s*,%s*%d+%s*,%s*%d+%s*%)",
        group = rgb_color,
        extmark_opts = { priority = 2000 },
      },
      rgba_color = {
        pattern = "rgba%(%s*%d+%s*,%s*%d+%s*,%s*%d+%s*,%s*[%d%.]+%s*%)",
        group = rgba_color,
        extmark_opts = { priority = 2000 },
      },
      rgba_hex_color = {
        pattern = "rgba%(%x%x%x%x%x%x%x%x%)",
        group = rgba_hex_color,
        extmark_opts = { priority = 2000 },
      },
      hsl_color = {
        pattern = "hsl%(%s*%d+%s*,%s*%d+%%?%s*,%s*%d+%%?%s*%)",
        group = hsl_color,
        extmark_opts = { priority = 2000 },
      },
      hsla_color = {
        pattern = "hsla%(%s*%d+%s*,%s*%d+%%?%s*,%s*%d+%%?%s*,%s*[%d%.]+%s*%)",
        group = hsla_color,
        extmark_opts = { priority = 2000 },
      },
    })
  end,
}
