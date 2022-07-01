---@diagnostic disable: undefined-global
vim.g.mapleader = " "

require('sets')
require('plugins')

-- setting up plugins
require('plugins.cmp')
require('plugins.colors')
require('plugins.compitest')
require('plugins.git')
require('plugins.lsp')
require('plugins.lspsaga')
require('plugins.lualine')
require('plugins.rust')
require('plugins.telescope')
require('plugins.tree')
require('plugins.treesitter')
require('plugins.ufo')


-- for switching between projects
vim.api.nvim_set_keymap('n', '<c-f>', ':silent !tmux neww tmux-sessionizer<CR>', { noremap = true })

-- extensions
vim.api.nvim_set_keymap('n', '<leader>u', ':UndotreeToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>g', ':LazyGit<CR>', { noremap = true })

-- telescope
vim.api.nvim_set_keymap('n', '<leader>f', ':Telescope find_files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>s', ':Telescope live_grep<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>b', ':Telescope current_buffer_fuzzy_find<CR>', { noremap = true1 })

-- Telescope harpoon
vim.api.nvim_set_keymap('n', '<leader>hf', ':Telescope harpoon marks<CR>', { noremap = true })

-- Telescope git-worktree
vim.api.nvim_set_keymap('n', '<leader>wf', ':lua require(\'telescope\').extensions.git_worktree.git_worktrees()',
    { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>wc', ':lua require(\'telescope\').extensions.git_worktree.create_git_worktree()',
    { noremap = true })

-- harpoon
vim.api.nvim_set_keymap('n', '<leader>ha', 'require(\'harpoon.mark\').add_file()', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>hn', 'require(\'harpoon.ui\').nav_next()', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>hp', 'require(\'harpoon.ui\').nav_prev()', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>hj', 'require(\'harpoon.ui\').nav_file(1)', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>hk', 'require(\'harpoon.ui\').nav_file(2)', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>hl', 'require(\'harpoon.ui\').nav_file(3)', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>h;', 'require(\'harpoon.ui\').nav_file(4)', { noremap = true })

-- movement b/w windows
vim.api.nvim_set_keymap('n', '<leader>vk', ':wincmd k<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>vj', ':wincmd j<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>vh', ':wincmd h<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>vl', ':wincmd l<CR>', { noremap = true })


-- auto commands
local au_utils = vim.api.nvim_create_augroup("Utils", { clear = true })

-- trim trailing whitespace
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    command = "%s/\\s\\+$//e",
    group = au_utils
})

-- show inlay_hints
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "TabEnter" }, {
    pattern = "*.rs",
    command = ":lua require'lsp_extensions'.inlay_hints{}",
    group = au_utils
})

-- lint
vim.api.nvim_create_autocmd("BufWritePost", {
    command = ":lua require('lint').try_lint()",
    group = au_utils
})
