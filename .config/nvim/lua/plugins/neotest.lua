return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<leader>rt", function() require("neotest").run.run() end, desc = "Run Nearest" },
      { "<leader>rs", function() require("neotest").summary.toggle() end, desc = "Run Nearest" },
    }
  },
  "nvim-neotest/neotest-go",
  "nvim-neotest/neotest-python",
}
