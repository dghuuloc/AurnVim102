-- START SETTING PATHS 
local fn = vim.fn
local on_windows = vim.loop.os_uname().version:match('Windows')

local function join_paths(...)
  local path_sep = on_windows and '\\' or '/'
  local result = table.concat({ ... }, path_sep)
  return result
end

local function getpath(arg)
  local path = fn.stdpath(arg)
  return fn.substitute(path, [[\(.*\)\zsnvim]], 'nvim', '')
end

vim.cmd([[set runtimepath=$VIMRUNTIME]])

local temp_dir
if on_windows then
	temp_dir = getpath('data')
else
	temp_dir = '/'
end

vim.cmd("set packpath=" .. join_paths(temp_dir, 'lazy'))
-- ENDING SETING PATHS

-- Automatically install packer
local lazypath = join_paths(temp_dir, 'lazy', 'lazy.nvim')		-- [install_path on Windows] ==> C:\Users\<<user_name>>\AppData\Local\nvim-data\lazy\lazy.nvim

if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- import/override with your plugins
  { import = "aurnvim.plugins" },
  { import = "aurnvim.plugins.lsp" },

})
