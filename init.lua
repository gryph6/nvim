--
-- NVIM Config
--

local isWindows = vim.loop.os_uname().sysname == "Windows_NT"

-- Set Line Numbers
vim.opt.number = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.ignorecase = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.expand('~/.vim/undodir')
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.opt.updatetime = 50

vim.opt.signcolumn = "yes:1" 

-- Use System Clipboard
vim.opt.clipboard = 'unnamedplus'

vim.opt.shortmess:append { I = true }

-- Code Folding
vim.opt.foldlevel = 20
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.o.updatetime = 250

-- Custom Diagnostics Visualization
vim.diagnostic.config({
  update_in_insert = false,
  virtual_text = false,
  underline = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "●", 
      [vim.diagnostic.severity.WARN] = "●", 
      [vim.diagnostic.severity.INFO] = "●", 
      [vim.diagnostic.severity.HINT] = "●", 
    },
  },
})

-- Set Leader Key
local map = vim.api.nvim_set_keymap
local silent = { silent = true, noremap = true }
map("", "<Space>", "<Nop>", silent)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Keybinding for File Explorer
vim.keymap.set("n", "<C-n>", vim.cmd.Ex)

-- Bootstrap Plugin Manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, 'lazy')
if not status_ok then
    return
end

lazy.setup({
    spec = {
        { 'ellisonleao/gruvbox.nvim', },
        { 'rebelot/kanagawa.nvim', },
        { 
            'tpope/vim-fugitive',
            config = function()
                vim.keymap.set("n", "<leader>git", '<cmd>below G<cr>')
            end
        },
        { 
            'petertriho/nvim-scrollbar',
            config = function()
                require("scrollbar").setup()
            end
        },
        { 
            'nvim-treesitter/nvim-treesitter',
            config = function()
                require("nvim-treesitter.configs").setup({})
            end
        },
        { 
            'nvim-telescope/telescope.nvim',
            dependencies = {
                'nvim-lua/plenary.nvim'
            },
            config = function()
                local builtin = require("telescope.builtin")

                vim.keymap.set('n', '<C-p>', builtin.git_files, {})
                vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
                vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
                vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
                vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
            end
        },
        {
            'nvim-lualine/lualine.nvim',
            dependencies = { 'nvim-tree/nvim-web-devicons' },
            config = function()
                require('lualine').setup({
                    options = {
                        component_separators = '',
                        section_separators = '',
                        always_show_tabline = true,
                    },
                    sections = {
                        lualine_a = {'mode'},
                        lualine_b = {},
                        lualine_c = {},
                        lualine_x = {},
                        lualine_y = {},
                        lualine_z = {'location'}
                    },
                    tabline = {
                        lualine_a = {
                            {'tabs', mode = 1 }
                        },
                    },
                })
            end
        },
        {
            'saghen/blink.cmp',
            version = 'v0.*',
            config = function()
                require('blink.cmp').setup({
                    keymap = { 
                        preset = 'default' 
                    },
                    appearance = {
                        use_nvim_cmp_as_default = true,
                        nerd_font_variant = 'mono'
                    },
                    signature = { 
                        enabled = true 
                    },
                    completion = {
                        menu = {
                            auto_show = function(ctx)
                                return ctx.mode ~= 'cmdline'
                            end
                        }
                    }
                })
            end
        },
        {
            "neovim/nvim-lspconfig",
            dependencies = {
              'saghen/blink.cmp',
            },
            config = function()
                local lspconfig = require('lspconfig')
                local blink_capabilities = require('blink.cmp').get_lsp_capabilities()

                lspconfig.clangd.setup({ capabilitiies = blink_capabilities })
                lspconfig.rust_analyzer.setup({ capabilities = blink_capabilities })
            end
        },
        {
            "github/copilot.vim",
            enabled = isWindows,
            config = function()
                vim.cmd.Copilot("disable")
            end
        }
    }
})

-- Setup custom highlighting on nvim start.
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.cmd.colorscheme("kanagawa")

        vim.cmd.highlight("clear SignColumn")
        vim.cmd.highlight("LineNr guibg=NONE")

        vim.cmd.highlight("clear DiagnosticSignError")
        vim.cmd.highlight("link DiagnosticSignError DiagnosticError")
        vim.cmd.highlight("clear DiagnosticSignWarn")
        vim.cmd.highlight("link DiagnosticSignWarn DiagnosticWarn")
        vim.cmd.highlight("clear DiagnosticSignInfo")
        vim.cmd.highlight("link DiagnosticSignInfo DiagnosticInfo")
        vim.cmd.highlight("clear DiagnosticSignHint")
        vim.cmd.highlight("link DiagnosticSignHint DiagnosticHint")
    end,
})

-- Floating panel on error hover
vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
    callback = function()
        vim.diagnostic.open_float(nil, {focus=false})
    end
})

-- 80 char limit in C files
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {
        "C:/Users/griffinS/git/Xbox.AccessoriesFirmware/src/XboxGameControllerDriver/*.c",
        "C:/Users/griffinS/git/Xbox.AccessoriesFirmware/src/XboxGameControllerDriver/*.h",
        "C:/os/src/gamecore/xbc/net/xvn/xvnpf/*.c",
        "C:/os/src/gamecore/xbc/net/xvn/xvnpf/*.h"
    },
    command = "match Error /\\%80v.\\+/",
})

-- Enable Copilot for work files.
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {
        "*",
    },
    callback = function()
        vim.cmd.Copilot("disable")
    end
})
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {
        "C:/os/src/gamecore/xbc/*",
    },
    callback = function()
        vim.cmd.Copilot("enable")
    end
})

