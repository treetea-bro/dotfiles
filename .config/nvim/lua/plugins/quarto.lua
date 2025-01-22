return {
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      {
        "<leader>qp",
        function()
          require("quarto").quartoPreview()
        end,
        desc = "Quarto Preview",
        mode = "n",
        silent = true,
        noremap = true,
      },
    },
    -- config = function()
    --   vim.g.python3_host_prog = '.venv/bin/python3'
    -- end,
  },
}
