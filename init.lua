--
-- NVIM Config
--

require "plugin_configs"

-- Set Line Numbers --
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

vim.opt.signcolumn = 'no' -- auto/yes/no

-- Use System Clipboard --
vim.opt.clipboard = 'unnamedplus'

vim.opt.shortmess:append { I = true }

-- Code Folding --
vim.opt.foldlevel = 20
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Set Leader Key --
local map = vim.api.nvim_set_keymap
local silent = { silent = true, noremap = true }
map("", "<Space>", "<Nop>", silent)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Keybinding for File Explorer --
vim.keymap.set("n", "<C-n>", vim.cmd.Ex)

--
-- Plugins
--

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

-- Use a protected call so we don't error out on first use --
local status_ok, lazy = pcall(require, 'lazy')
if not status_ok then
    return
end

lazy.setup({
    spec = {
        { 
            'ellisonleao/gruvbox.nvim',
            config = config_gruvbox
        },
        { 
            'tpope/vim-fugitive',
            config = config_fugitive
        },
        { 
            'petertriho/nvim-scrollbar',
            config = config_scrollbar
        },
        { 'nvim-treesitter/nvim-treesitter' },
        { 'nvim-treesitter/nvim-treesitter-context' },
        { 'nvim-telescope/telescope.nvim',
            tag = "0.1.6",
            dependencies = {
                'nvim-lua/plenary.nvim'
            },
            config = config_telescope,
        },
        
        -- LSP --
        {
            'VonHeikemen/lsp-zero.nvim', 
            branch = 'v3.x',
            priority = 100,
            config = config_lsp_zero
        },
        {'neovim/nvim-lspconfig'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/nvim-cmp'},
        {
            'williamboman/mason.nvim',
            config = config_mason
        },
        {
            'williamboman/mason-lspconfig.nvim',
            config = config_mason_lspconfig
        },
    }
})

