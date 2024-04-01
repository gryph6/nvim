local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    'ellisonleao/gruvbox.nvim',
    'nvim-telescope/telescope.nvim', version = "0.1.6", dependencies = { 'nvim-lua/plenary.nvim' },
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
        { 'tpope/vim-fugitive' },
        { 'theprimeagen/harpoon' },
        { 'nvim-telescope/telescope.nvim', 
            tag = "0.1.6", 
            dependencies = { 
                'nvim-lua/plenary.nvim' 
            } 
        },
    }
})

