-- must be set before loading polyglot
vim.g.polyglot_disabled = {'latex', 'markdown'}

require('plugins')
require('defaults')
require('visual')
require('languages')
require('terminal')
require('filetree')
require('finder')
require('undotree')
require('commands')
require('scm')
require('ide')
require('utils')
require('mappings')

-- optional system-specific configuration
-- pcall avoids errors if the config doesn't exist
pcall(require, 'systemconfig')

-- allow project-specific settings
local local_vimrc = vim.fn.getcwd() .. '/.exrc'
if vim.loop.fs_stat(local_vimrc) then
  print("Sourcing local config")
  vim.cmd('source '..local_vimrc)
end
