local M = {}

function M.setup()
  require('base16-colorscheme').setup {
    -- Backgrounds
    base00 = '{{colors.surface.default.hex}}',           -- Default background
    base01 = '{{colors.surface_container.default.hex}}', -- Status bars, lighter bg
    base02 = '{{colors.surface_container_high.default.hex}}', -- Selection bg
    base03 = '{{colors.outline.default.hex}}',           -- Comments, invisibles

    -- Foregrounds
    base04 = '{{colors.on_surface_variant.default.hex}}', -- Dark fg (status bars)
    base05 = '{{colors.on_surface.default.hex}}',         -- Default fg
    base06 = '{{colors.on_surface.default.hex}}',         -- Light fg
    base07 = '{{colors.on_background.default.hex}}',      -- Lightest fg

    -- Accents
    base08 = '{{colors.error.default.hex}}',              -- Variables, errors
    base09 = '{{colors.tertiary.default.hex}}',           -- Integers, constants
    base0A = '{{colors.secondary.default.hex}}',          -- Classes, search bg
    base0B = '{{colors.primary.default.hex}}',            -- Strings, diff inserted
    base0C = '{{colors.tertiary_fixed_dim.default.hex}}', -- Regex, escape chars
    base0D = '{{colors.primary_fixed_dim.default.hex}}',  -- Functions, methods
    base0E = '{{colors.secondary_fixed_dim.default.hex}}',-- Keywords, storage
    base0F = '{{colors.error_container.default.hex}}',    -- Deprecated, embedded
  }
end

-- SIGUSR1 handler: reload theme live when Noctalia regenerates it
local signal = vim.uv.new_signal()
signal:start('sigusr1', vim.schedule_wrap(function()
  package.loaded['colors'] = nil
  require('colors').setup()
end))

return M
