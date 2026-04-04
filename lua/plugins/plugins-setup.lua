-- Unified Plugin Configuration File
-- All individual plugin files have been merged into this specification.
return {
    -- Catppuccin Theme
    { "catppuccin/nvim", name = "catppuccin", priority = 1000, config = function()
        require("catppuccin").setup({ flavour = "frappe", transparent_background = true })
        vim.cmd.colorscheme("catppuccin")
    end },

    -- Core UI Elements
    { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, config = function() require("lualine").setup({ options = { theme = "catppuccin" } }) end },
    { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" }, config = function() require("nvim-tree").setup() end },
    { "akinsho/bufferline.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, config = function() require("bufferline").setup() end },

    -- Treesitter for advanced syntax highlighting
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "vim", "vimdoc", "lua", "bash", "c", "cpp", "javascript", "json", "python", "typescript", "css", "rust", "markdown", "markdown_inline"},
            highlight = { enable = true },
            indent = { enable = true },
            auto_install = true,
        })
    end },

    -- LSP and Completion Engine
    { "williamboman/mason.nvim", config = function() require("mason").setup() end },
    { "williamboman/mason-lspconfig.nvim", config = function() require("mason-lspconfig").setup() end },
    "neovim/nvim-lspconfig", "hrsh7th/nvim-cmp", "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip",

    -- Utility Plugins
    { "numToStr/Comment.nvim", config = function() require("Comment").setup() end },
    { "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup() end },
    { "akinsho/toggleterm.nvim", version = "*", config = function() require("toggleterm").setup() end },
    { "lewis6991/gitsigns.nvim", config = function() require("gitsigns").setup() end }
}
