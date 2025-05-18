-- load modules
require("core.options") -- ./core/options.lua
require("core.keymaps") -- ./core/keypams.lua
require("core.autocmds") -- ./core/autocmds.lua
require("custom.example")


-- install lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- plugins for aesthetics
  require("plugins.colorscheme"),
  require("plugins.mini-ui"),
  require("plugins.noice-classic"),
  require("plugins.indent-blankline"),

  -- file exploration
  require("plugins.nvim-tree"),
  require("plugins.picker"),


  -- general programming utilities
  require("plugins.lsp"),
  require("plugins.autocompletion"),
  require("plugins.autoformatting"),
  require("plugins.mini-nvim"),
  require("plugins.treesitter"),

  require("plugins.markdown"),
  require("plugins.misc"),
}

require("lazy").setup(plugins)

