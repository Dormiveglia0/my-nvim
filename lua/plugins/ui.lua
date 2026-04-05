return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "frappe",
        transparent_background = true,
        custom_highlights = function(colors)
          return {
            LineNr = { fg = colors.text },
            CursorLineNr = { fg = colors.mauve, style = { "bold" } },
          }
        end
      })
      vim.cmd.colorscheme("catppuccin")
    end
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "catppuccin" },
    config = function()
      require("plugin_configs.lualine")
    end
  },

  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugin_configs.bufferline")
    end
  },

  { 
    "sphamba/smear-cursor.nvim",
    config = function()
      require("plugin_configs.smear-cursor")
    end
  },

  { 
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    config = function()
      local notify_status_ok, notify = pcall(require, "notify")
      if notify_status_ok then
        notify.setup({
          background_colour = "#000000",
        })
      end
      require("plugin_configs.noice")
    end
  },

  { 
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugin_configs.dashboard")
    end
  },

  { 
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufReadPre",
    config = function()
      require("plugin_configs.indent-blankline")
    end
  },
}
