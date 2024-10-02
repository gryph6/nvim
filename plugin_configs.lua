--
-- Plugin Configuration Functions
--

function config_gruvbox()
    vim.cmd.colorscheme("gruvbox")
end

function config_fugitive()
    vim.keymap.set("n", "<leader>git", '<cmd>below G<cr>')
end

function config_scrollbar()
    require("scrollbar").setup()
end

function config_telescope()
    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<C-p>', builtin.git_files, {})
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
end

function config_lsp_zero()
    local lsp_zero = require('lsp-zero')

    lsp_zero.on_attach(function(_, bufnr)
      -- see :help lsp-zero-keybindings
      -- to learn the available actions
      lsp_zero.default_keymaps({buffer = bufnr})
    end)
end

-- to learn how to use mason.nvim with lsp-zero
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
function config_mason()
    require('mason').setup({})
end

function config_mason_lspconfig()
    local lsp_zero = require('lsp-zero')

    require('mason-lspconfig').setup({
      ensure_installed = {},
      handlers = {
        lsp_zero.default_setup,
      },
    })
end

