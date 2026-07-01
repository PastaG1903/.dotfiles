local M = {}

function M.setup()
  require('base16-colorscheme').setup {
    -- Backgrounds
    base00 = '#111f2c',           -- Default background
    base01 = '#1d3449', -- Status bars, lighter bg
    base02 = '#1a2e42', -- Selection bg
    base03 = '#5f6a73',           -- Comments, invisibles

    -- Foregrounds
    base04 = '#afb3b6', -- Dark fg (status bars)
    base05 = '#f2f2f3',         -- Default fg
    base06 = '#f2f2f3',         -- Light fg
    base07 = '#f2f2f3',      -- Lightest fg

    -- Accents
    base08 = '#fd4663',              -- Variables, errors
    base09 = '#9866cc',           -- Integers, constants
    base0A = '#5c5dd6',          -- Classes, search bg
    base0B = '#67a7e4',            -- Strings, diff inserted
    base0C = '#be96e9', -- Regex, escape chars
    base0D = '#93c0ec',  -- Functions, methods
    base0E = '#9696e9',-- Keywords, storage
    base0F = '#900017',    -- Deprecated, embedded
  }
end

-- SIGUSR1 handler: reload theme live when Noctalia regenerates it
local signal = vim.uv.new_signal()
signal:start('sigusr1', vim.schedule_wrap(function()
  package.loaded['colors'] = nil
  require('colors').setup()
end))

return M
