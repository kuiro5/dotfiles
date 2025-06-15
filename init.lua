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

-- Enable syntax highlighting
vim.cmd("syntax enable")

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
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "black" })

-- Remove search highlight when pressing ESC in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>", { silent = true })

-- Strip trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local save_cursor = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[silent! %s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, save_cursor)
  end,
})

---- Set termguicolors for true color support
vim.o.termguicolors = true
vim.api.nvim_set_hl(0, "Normal", { fg = "NONE", bg = "NONE" })

-- Plugins
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
                -- Close telescope on single escape
                ["<esc>"] = require('telescope.actions').close,
              },
              n = { -- Normal mode
                ["j"] = actions.move_selection_next,
                ["k"] = actions.move_selection_previous,
              },
            }
          },
        })
      end,
      keys = {
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
        { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
        { "<C-f>", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
      },
    },
    {
      "ggandor/leap.nvim",
      config = function()
        require("leap").add_default_mappings()

        -- Remove conflicting mappings
        vim.keymap.del('n', 's')
        vim.keymap.del('x', 's')

        -- Use gs for leap
        vim.keymap.set({'n', 'x', 'o'}, 'gs', function()
          require('leap').leap { target_windows = { vim.fn.win_getid() } }
        end)
      end,
    },
    {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
        require('lualine').setup {
          options = {
            theme = 'auto',
           section_separators = '',
            component_separators = '',
            icons_enabled = true,
          },
        }
      end,
    },
    {
      'akinsho/bufferline.nvim',
      lazy = false,
      dependencies = 'nvim-tree/nvim-web-devicons',
      config = function()
        require('bufferline').setup {
          options = {
            -- Show only the filename, not full path, like airline's fnamemod ':t'
            name_formatter = function(buf)
              return vim.fn.fnamemodify(buf.path, ':t')
            end,
            -- Enable Powerline style separators (you need a patched font)
            separator_style = "thin",
            -- Enable bufferline as tabline
            always_show_bufferline = true,
            show_buffer_close_icons = true,
            show_buffer_icons = false,
            show_close_icon = false,
            -- Show diagnostics if you want (optional)
            diagnostics = "nvim_lsp",
            offsets = {
              {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "left",
              }
            },
      }}
        vim.api.nvim_set_hl(0, 'BufferLineFill', {fg="#0d2a34", bg="#0d2a34"})
        vim.api.nvim_set_hl(0, 'BufferLineSeparator', {fg="#0d2a34", bg="#0d2a34"})
        vim.api.nvim_set_hl(0, 'BufferLineSeparatorSelected', {fg="#0d2a34", bg="#0d2a34"})
      end
    },
    {
      "echasnovski/mini.bufremove",
      version = "*",
      config = function()
        local bufremove = require("mini.bufremove")

        -- Replace :BD
        vim.keymap.set("n", "<leader>bd", function() bufremove.delete(0, false) end, { desc = "Delete buffer" })

        -- Replace :bd!
        vim.keymap.set("n", "<leader>bd!", function() bufremove.delete(0, true) end, { desc = "Force delete buffer" })

        -- Replace :Bdelete other
        vim.keymap.set("n", "<leader>bdo", function()
          local cur = vim.api.nvim_get_current_buf()
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if buf ~= cur and vim.api.nvim_buf_is_loaded(buf) then
              bufremove.delete(buf, false)
            end
          end
        end, { desc = "Delete other buffers" })
      end,
    },
     -- Mason for managing LSP servers, DAP, linters, formatters
    {
      "williamboman/mason.nvim",
      build = ":MasonUpdate",
      config = true,
    },

    -- Mason integration with lspconfig
    {
      "williamboman/mason-lspconfig.nvim",
      dependencies = { "williamboman/mason.nvim" },
      config = true,
    },

    -- Core LSP configurations
    {
      "neovim/nvim-lspconfig",
      dependencies = { "williamboman/mason.nvim" },
      config = function()
        local lspconfig = require("lspconfig")

        -- Setup Lua language server
        lspconfig.lua_ls.setup({
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim" } },
              workspace = { library = vim.api.nvim_get_runtime_file("", true) },
              telemetry = { enable = false },
            },
          },
        })

        -- Setup Go language server
        lspconfig.gopls.setup({})
      end,
    },

    -- Autocompletion framework
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "hrsh7th/cmp-nvim-lsp",   -- LSP source for cmp
        "L3MON4D3/LuaSnip",       -- Snippet engine
        "saadparwaiz1/cmp_luasnip" -- Snippet completions
      },
      config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          mapping = cmp.mapping.preset.insert({
            ["<Tab>"] = cmp.mapping.select_next_item(),
            ["<S-Tab>"] = cmp.mapping.select_prev_item(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
          }),
          sources = {
            { name = "nvim_lsp" },
            { name = "luasnip" },
          },
        })
      end,
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
