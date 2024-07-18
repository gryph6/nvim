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
        { 'ellisonleao/gruvbox.nvim' },
        { 'rebelot/kanagawa.nvim' },
        { 'tpope/vim-fugitive' },
        { 'petertriho/nvim-scrollbar' },
	{ 'preservim/tagbar' },
        { 'nvim-telescope/telescope.nvim',
            tag = "0.1.6",
            dependencies = {
                'nvim-lua/plenary.nvim'
            }
        },
        
        -- LSP
        -- {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
        -- {'neovim/nvim-lspconfig'},
        -- {'hrsh7th/cmp-nvim-lsp'},
        -- {'hrsh7th/nvim-cmp'},
        -- {'williamboman/mason.nvim'},
        -- {'williamboman/mason-lspconfig.nvim'},
    }
})

