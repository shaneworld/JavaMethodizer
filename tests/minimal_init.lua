-- tests/minimal_init.lua
vim.opt.runtimepath:append(",.")
vim.opt.runtimepath:append(",./.deps/plenary.nvim")
vim.cmd [[runtime plugin/plenary.vim]]

-- 禁用加载用户配置
vim.opt.loadplugins = false
vim.cmd [[set runtimepath-=~/.config/nvim]]
vim.cmd [[set packpath-=~/.config/nvim]]
