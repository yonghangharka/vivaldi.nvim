local util = require('vivaldi.util')
local cfg = require('vivaldi.config')

local nvim08 = (vim.fn.has('nvim-0.8') == 1)
if not nvim08 then
  return vim.notify(
  'vivaldi.nvim: Your Neovim version is outdated, please update to 0.8 or higher',
  3
  )
end
-- Load the theme
local set = function(theme)
  util.load(theme)
  vim.cmd(
      [[command! -nargs=* -complete=custom,v:lua.package.loaded.vivaldi.theme_complete vivaldi  lua require('vivaldi.functions').change(<f-args>)]])
end

local clear = function()
  package.loaded['vivaldi'] = nil
  package.loaded['vivaldi.util'] = nil
  package.loaded['vivaldi.colors'] = nil
  package.loaded['vivaldi.theme'] = nil
  package.loaded['vivaldi.functions'] = nil

  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
end

local function theme_complete()
  local schemes = require'vivaldi.functions'.all_schemes
  return table.concat(schemes, '\n')

end

return {set = set, clear = clear, theme_complete = theme_complete, setup = cfg.setup}
