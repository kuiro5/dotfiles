-- Josh Kuiros
-- init.lua

-- Use system clipboard
vim.o.clipboard = "unnamedplus"

-- Show line numbers
vim.wo.number = true

-- Show relative line numbers
vim.wo.relativenumber = true

-- Disable swapfile
vim.o.swapfile = false

-- Case-insensitive search, unless uppercase used
vim.o.ignorecase = true
vim.o.smartcase = true

-- Set utf-8 encoding
vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"

-- Make backspace work more intuitively in insert mode
vim.o.backspace = "indent,eol,start"

-- Don't unload buffers when they are abandoned, stay in background,
-- allows switching between buffers without saving
vim.o.hidden = true

-- Set unix line endings
vim.o.fileformat = "unix"

-- Try Unix line endings first for new buffers, then fallback to DOS
vim.o.fileformats = "unix,dos"

-- Save up to 100 marks, enable capital marks
vim.o.viminfo = "'100,f1"

-- Disable screen redraw during macros etc., improves performance
vim.o.lazyredraw = true

-- Indentation settings
vim.o.expandtab = true       -- Convert tabs to spaces
vim.o.autoindent = true      -- Copy indent from line above
vim.o.smartindent = true     -- Smart C-like indentation
vim.o.shiftwidth = 2         -- Size of auto-indent
vim.o.softtabstop = 2        -- Two spaces per tab press
vim.o.tabstop = 2            -- Set tab width to two

-- Both of these leader configurations are required
-- for lazy.nvim and need to be configured before loading it
-- Set <Space> as the leader key
vim.g.mapleader = " "
-- Set \\ as the local leader key
vim.g.maplocalleader = "\\"

-- 120 character color column
vim.o.colorcolumn = "120"
vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = "black" })

-- Remove search highlight when pressing ESC in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>", { silent = true })

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
   -- File explorer: nvim-tree.lua
    {
      "nvim-tree/nvim-tree.lua",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        require("nvim-tree").setup({
          view = { width = 30, side = "right" },
          git = { enable = true },
          renderer = { icons = { show = { git = true, folder = true, file = true } } },
        })
        vim.keymap.set("n", "<leader>pt", "<cmd>NvimTreeToggle<cr>", { noremap = true, silent = true, desc = "Toggle file tree" })
        vim.keymap.set("n", "<leader>pf", "<cmd>NvimTreeFindFile<cr>", { noremap = true, silent = true, desc = "Open tree and find current file" })
      end,
    },

    -- Fuzzy finder: telescope.nvim with fzf native extension
    {
      'nvim-telescope/telescope.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      },
      config = function()
        local actions = require("telescope.actions")

        require('telescope').setup({
          defaults = {
            prompt_prefix = "🔍 ",
            sorting_strategy = "ascending",
            layout_config = {
              horizontal = { mirror = false },
              vertical = { mirror = false },
            },
            mappings = {
              i = { -- Insert mode
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-n>"] = actions.cycle_history_next,
                ["<C-p>"] = actions.cycle_history_prev,
              },
              n = { -- Normal mode
                ["j"] = actions.move_selection_next,
                ["k"] = actions.move_selection_previous,
              },
            }
          },
        })
        require('telescope').load_extension('fzf')
      end,
      keys = {
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
      },
    },
    {
      "ggandor/leap.nvim",
      config = function()
        require("leap").add_default_mappings()
      end,
    },
    {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
        require('lualine').setup {
          options = {
            theme = 'auto',
            component_separators = '|',
            section_separators = '',
          },
        }
      end,
    }
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
