-- Autoformatter setup
return {
  "stevearc/conform.nvim",
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>ff",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = "",
      desc = "[F]ormat buffer",
    },
  },
  opts = {
    notify_on_error = false,
    -- Disable format on save globally
    format_on_save = false,
    formatters_by_ft = {
      lua = { "stylua" }, -- Use stylua without args
      markdown = { "prettier" },
    },
  },
}
