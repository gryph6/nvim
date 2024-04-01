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

require("lazy").setup({
    'nvim-telescope/telescope.nvim', 
    tag = '0.1.6', 
    dependencies = { 
        'nvim-lua/plenary.nvim' 
    },

    'morhetz/gruvbox',
    
    'nvim-treesitter/nvim-treesitter', 
    init = ':TSUpdate',

    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
})

