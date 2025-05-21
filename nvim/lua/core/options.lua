local opt = vim.opt
local g = vim.g

-- Global options
g.mapleader = ' '
g.maplocalleader = ' '
g.have_nerd_font = true
g.no_cecutil_maps = 1

-- Editor UI options
opt.number = true
opt.relativenumber = true
opt.mouse = 'a'
opt.showmode = false
opt.signcolumn = 'yes'
opt.cursorline = true
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- UX options
opt.breakindent = true
opt.scrolloff = 15
opt.updatetime = 250
opt.timeoutlen = 300
opt.inccommand = 'split'

-- Split behavior
opt.splitright = true
opt.splitbelow = true

-- File handling options
opt.swapfile = false
opt.undofile = true

-- Search options
opt.ignorecase = true
opt.smartcase = true

-- Enable inlay hints if available
if vim.lsp.inlay_hint then
  vim.lsp.inlay_hint.enable()
end

-- Setup clipboard (deferred to avoid startup issues)
vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)

return {}
