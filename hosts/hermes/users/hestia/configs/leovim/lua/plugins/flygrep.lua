return {
  {
    "wsdjeg/flygrep.nvim",
    dependencies = {
      { "wsdjeg/job.nvim" }
    },
    config = function()
      require('flygrep').setup({enable_preview = true,})
    end,
  },
}
