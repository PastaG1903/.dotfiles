return {
{
  "CRAG666/code_runner.nvim",
  cmd = { "RunCode", "RunFile", "RunProject", "RunClose", "CRFiletype", "CRProjects" },
  -- keys = { "<leader>r" }, -- add the mappings you use
  opts = {
    filetype = {
      python = "python",
      julia = "julia",
    },
  },
}
}
