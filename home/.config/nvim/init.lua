require('defaults')
require('plugins')
require('visual')
require('terminal')
require('commands')
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
  vim.cmd('source ' .. local_vimrc)
end
