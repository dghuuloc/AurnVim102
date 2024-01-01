--[[ Set leadermap ]]
vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})
--- use space as a the leader key
-- vim.g.mapleader = ' ' --[[By default is \, backslash]]--

-- key mapper --
local map_key = function(mode, key, result)
  vim.api.nvim_set_keymap(
    mode,
    key,
    result,
    {noremap = true, silent = true}
  )
end

--[[ Neo-tree ]]
vim.api.nvim_set_keymap('n', '<leader>e', ':Neotree filesystem reveal left toggle<CR>', {noremap = true, silent = true})

--[[ Telescope ]]
vim.api.nvim_set_keymap('n', '<C-f>', ':Telescope find_files<CR>', {noremap = true, silent = true})

--[[ Comments ]]
vim.api.nvim_set_keymap("n", '<C-_>', ':Comment<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", '<C-_>', ':Comment<CR>', {noremap = true, silent = true})

--[[ better window movement ]]
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {noremap = true, silent = true})

--[[ resize with arrows ]]
vim.api.nvim_set_keymap('n', '<C-Up>', ':resize -2<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<C-Down>', ':resize +2<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<C-Left>', ':vertical resize -2<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<C-Right>', ':vertical resize +2<CR>', {silent = true})

--[[ Tab switch buffer ]]
vim.api.nvim_set_keymap('n', '<TAB>', ':bnext<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<S-TAB>', ':bprevious<CR>', {noremap = true, silent = true})

--[[ Better indenting ]]
vim.api.nvim_set_keymap('v', '<', '<gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '>', '>gv', {noremap = true, silent = true})

--[[ Better escape ]]
vim.api.nvim_set_keymap('i', 'jj', '<ESC>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', 'kk', '<ESC>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', 'jk', '<ESC>', {noremap = true, silent = true})

--[[ Move text up and down ]]
vim.api.nvim_set_keymap("v", "<A-j>", ":m .+1<CR>==", {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", "<A-k>", ":m .-2<CR>==", {noremap = true, silent = true})

--[[ Visual Block ]]
--[[ Move selected line / block of text in visual mode ]]
vim.api.nvim_set_keymap('x', 'K', ':move \'<-2<CR>gv-gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', 'J', ':move \'>+1<CR>gv-gv', {noremap = true, silent = true})

--[[ Toggle the QuickFix window ]]
vim.api.nvim_set_keymap('', '<C-q>', '<Cmd>q<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('', '<C-w>', '<Cmd>w<CR>', {noremap = true, silent = true})

--[[ Toggle the Comment ]] 
vim.api.nvim_set_keymap('', '<leader>c', ':Comment<CR>', {noremap = true, silent = true})


