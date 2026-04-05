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
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufReadPre",
    config = function()
      require("plugin_configs.indent-blankline")
    end
  },

  -- ==========================================
  -- 🌟 恢复 Noice.nvim (悬浮命令行、命令补全提示)
  -- ==========================================
  { 
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      })
    end
  },
}
