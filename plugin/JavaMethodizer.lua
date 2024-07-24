-- plugin/JavaMethodizer.lua
if vim.g.loaded_JavaMethodizer == 1 then
  return
end
vim.g.loaded_JavaMethodizer = 1

vim.api.nvim_create_user_command('JavaGenerateMethods', function()
  require('JavaMethodizer').generate_methods()
end, {})
